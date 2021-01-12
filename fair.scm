(define-syntax conjs
  (syntax-rules ()
    ((_ g) g)
    ((_ g1 g2 g ...) (conjs `(&& ,g1 . ,g2) g ...))))


(define-syntax fresh
  (syntax-rules ()
    ((_ (x ...) g ...)
      (lambda (state)
          (let ((scope (subst-scope (state-S state))))
            (let ((x (var scope)) ...)
              (values (conjs g ...) state)))))))


(define-syntax disjs
  (syntax-rules ()
    ((_ g) g)
    ((_ g1 g2 g ...) (disjs `(|| ,g1 . ,g2) g ...))))


(define-syntax conde
  (syntax-rules ()
    ((_ (g0 ...) (g1 ...) ...)
      (lambda (state)
        (let ((state (state-with-scope state (new-scope))))
          (values (disjs
              (conjs g0 ...)
              (conjs g1 ...) ...) state))))))

(define-syntax ==
  (syntax-rules ()
    ((_ a b)
      `(== ,a ,b))))


(define (disj-cmb stream1 stream2)
  (cond
    ((null? stream1) stream2)
    ((null? stream2) stream1)
    (else `(disj ,stream1 . ,stream2))))


(define (goal-to-stream upd state goal)
  (letrec ((g2s
    (lambda (stream goal)
      (pmatch `(,stream ,goal)

        [(,stream ())
          (error "Goal is null.")]

        [(() ,goal)
          stream]

        [((disj ,d1 . ,d2) ,goal)
          (disj-cmb (g2s d1 goal) (g2s d2 goal))]

        [((conj ,state . ,conjs) ,goal) (guard (procedure? goal))
          (let-values (((goal state) (goal state)))
            (g2s `(conj ,state . ,conjs) goal))]

        [((conj ,state . ,conjs) (== ,t1 ,t2))
          (let ((new-state ((==^ t1 t2) state)))
            (if new-state `(conj ,new-state . ,conjs) '()))]

        [(,stream (&& ,c1 . ,c2))
          (g2s (g2s stream c1) c2)]

        [(,stream (|| ,d1 . ,d2))
          (disj-cmb (g2s stream d1) (g2s stream d2))]

        [((conj ,state . ,conjs) ,goal)
          `(conj ,state . ,(append conjs (list (cons goal (upd state goal)))))]))))
    (g2s `(conj ,state . ()) goal)))


(define (unfold upd state call)
  (let ((relation  (cdaar call))
        (arguments (cdar call))
        (upd       (lambda (s c) (upd call s c))))
        (goal-to-stream upd state (apply relation arguments))))


(define (push conjs1 conjs2 stream)
  (pmatch stream
    [() stream]
    [(disj ,d1 . ,d2)
      `(disj ,(push conjs1 conjs2 d1) . ,(push conjs1 conjs2 d2))]
    [(conj ,state . ,conjs)
      `(conj ,state . ,(append conjs1 (append conjs conjs2)))]))


(define (step sep upd new stream)
  (pmatch stream
    [(disj ,d1 . ,d2)
      (let-values (((d1 answer) (step sep upd new d1)))
        (values (disj-cmb d2 d1) answer))]
    [(conj ,state . ()) (values '() state)]
    [(conj ,state . ,conjs)
      (let-values (((conjs1 conjs2)
                    (sep state conjs)))
             (if (null? conjs2)
                 (step sep upd new
                       `(conj ,state . ,(map (lambda (c) (cons (car c) (new state c))) conjs)))
                 (values (push conjs1 (cdr conjs2) (unfold upd state (car conjs2))) #f)))]))


(define (init-state new goal)
  (goal-to-stream new empty-state goal))


(define (run n sep upd new goal)
  (letrec ((run^ (lambda (n stream)
    (if (zero? n) '()
    (let-values (((stream answer) (step sep upd new stream)))
     (if (null? stream)
       (if answer `(,answer) '())
       (if answer
        (cons answer (run^ (if n (- n 1) n) stream))
        (run^ n stream))))))))
  (run^ n (init-state new goal))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (upd-unit p s c) #f)
(define (new-unit s c) #f)
(define (sep-unit s cs) (values '() cs))
(define (step-unit stream) (step sep-unit upd-unit new-unit stream))
(define (run-unit n goal) (run n sep-unit upd-unit new-unit goal))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (term-foldr f acc t)
  (if (pair? t) (f (car t) (term-foldr f acc (cdr t))) (f t acc)))


(define (height state term)
  (let ((t (walk term (state-S state))))
    (cond
      ((and (list? t) (pair? t)) (+ 1 (max (height state (car t)) (height state (cdr t)))))
      ((pair? t) (+ 1 (term-foldr (lambda (t acc) (max acc (height state t))) 0 t)))
      (else 0))))


(define (sublist bools list)
  (cond
    ((null? bools) '())
    ((car bools) (cons (car list) (sublist (cdr bools) (cdr list))))
    (else (sublist (cdr bools) (cdr list)))))


(define (split-by-pred pred list)
  (cond
    ((null? list) (values '() '()))
    (else (if (pred (car list))
      (values '() list)
      (let-values (((list1 list2) (split-by-pred pred (cdr list))))
        (values (cons (car list) list1) list2))))))


(define (is-not-free s t)
  (not (var? (walk t (state-S s)))))


(define (check-two-lists p l1 l2)
  (or (null? l1) (null? l2)
      (and (p (car l1) (car l2)) (check-two-lists p (cdr l1) (cdr l2)))))


(define (upd-fair rel-info)
  (lambda (p s c)
    (let ((name (caaar p))
          (args (cdar p))
          (prev (cadr p)))
    (pmatch (intmap-ref rel-info name)
      [(unbound) (error "Undefined relation")]
      [,args-info (cons (intmap-set prev name
        (map (lambda (t) (height s t)) (sublist args-info args))) #t)]))))


(define (new-fair s c)
  `(,empty-intmap . #f))


(define (sep-fair rel-info)
  (let ((pred
    (lambda (s c)
      (let ((history (cadr c))
            (name    (caaar c))
            (args    (cdar c)))
      (pmatch (intmap-ref rel-info name)
        [(unbound) (error "Undefined relation.")]
        [,args-info
        (let* ((args (sublist args-info args))
              (curr-hs (map (lambda (t) (height s t)) args)))
        (and (foldr (lambda (t acc) (or acc (is-not-free s t))) #f args)
          (pmatch (intmap-ref history name)
            [(unbound) #t]
            [,prev-hs
                (and (check-two-lists >= prev-hs curr-hs)
                     (not (check-two-lists <= prev-hs curr-hs)))])))])))))
  (lambda (s cs)
    (let-values (((l1 l2) (split-by-pred (lambda (c) (pred s c)) cs)))
      (if (null? l2) (split-by-pred (lambda (c) (not (cddr c))) cs) (values l1 l2))))))


(define (run-fair n rel-info goal)
  (run n (sep-fair rel-info) (upd-fair rel-info) new-fair goal))
