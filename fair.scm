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

(define-syntax =/=
  (syntax-rules ()
    ((_ a b)
      `(=/= ,a ,b))))

(define-syntax numbero
  (syntax-rules ()
    ((_ a )
      `(numbero ,a))))

(define-syntax stringo
  (syntax-rules ()
    ((_ a )
      `(stringo ,a))))

(define-syntax symbolo
  (syntax-rules ()
    ((_ a )
      `(symbolo ,a))))

(define-syntax absento
  (syntax-rules ()
    ((_ a b)
      `(absento ,a ,b))))

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

        [((conj ,state . ,conjs) (=/= ,t1 ,t2))
          (let ((new-state ((=/=^ t1 t2) state)))
            (if new-state `(conj ,new-state . ,conjs) '()))]

        [((conj ,state . ,conjs) (numbero ,t))
          (let ((new-state ((numbero^ t) state)))
            (if new-state `(conj ,new-state . ,conjs) '()))]

        [((conj ,state . ,conjs) (stringo ,t))
          (let ((new-state ((stringo^ t) state)))
            (if new-state `(conj ,new-state . ,conjs) '()))]

        [((conj ,state . ,conjs) (symbolo ,t))
          (let ((new-state ((symbolo^ t) state)))
            (if new-state `(conj ,new-state . ,conjs) '()))]

        [((conj ,state . ,conjs) (absento ,t1 ,t2))
          (let ((new-state ((absento^ t1 t2) state)))
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
      `(conj ,state . ,(append conjs1 (append conjs conjs2)))]
    [,e (error 'push (format "stream = ~s\n" stream))]))


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
                 (values (push conjs1 (cdr conjs2) (unfold upd state (car conjs2))) #f)))]
    [,s (error 'step (format "stream = ~s\n" stream))]))


(define (init-state new goal)
  (goal-to-stream new empty-state goal))


(define (run-f n sep upd new goal)
  (letrec ((run^ (lambda (n stream)
    (if (zero? n) '()
    (let-values (((stream answer) (step sep upd new stream)))
     (if (null? stream)
       (if answer `(,answer) '())
       (if answer
        (cons answer (run^ (if n (- n 1) n) stream))
        (run^ n stream))))))))
  (let ((state (init-state new goal)))
    (if (null? state) '() (run^ n state)))))

  (define-syntax run
    (syntax-rules ()
      ((_ n sup (q) g1 ...)
        (let* ((scope (subst-scope (state-S empty-state)))
               (q (var scope))
               (stream (run-f n (car sup) (cadr sup) (caddr sup) (fresh () g1 ...))))
          (map (lambda (st) ((reify q) (state-with-scope st nonlocal-scope))) stream)))
      ((_ n sup (q0 ...) g0 ...)
       (run n sup (x)
         (fresh (q0 ...)
           g0 ...
           (== (list q0 ...) x))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (upd-unit p s c) #f)
(define (new-unit s c) #f)
(define (sep-unit s cs) (values '() cs))
(define sup-unit (list sep-unit upd-unit new-unit))

(define-syntax run-unit
  (syntax-rules ()
    ((_ n (q0 ...) g0 ...) (run n sup-unit (q0 ...) g0 ...))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (term-foldr f acc t)
  (if (pair? t) (f (car t) (term-foldr f acc (cdr t))) (f t acc)))


(define (height state term)
  (let ((t (walk term (state-S state))))
    (cond
      ((var?    t) 1)
      ((symbol? t) 1)
      ((null?   t) 1)
      ((number? t) 1)
      ((pair?   t) (+ 1 (max (height state (car t)) (height state (cdr t)))))
      (else (error 'height (format "term = ~s\n" t))))))


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
      [(unbound) (error 'upd-fair (format "name = ~s\n" name))]
      [,args-info (cons (intmap-set prev name
        (map (lambda (t) (height s t)) (sublist args-info args))) #t)]))))


(define (new-fair s c)
  `(,empty-intmap . #f))


(define (sep-fair-pred rel-info s c)
  (let ((history (cadr c))
        (name    (caaar c))
        (args    (cdar c)))
  (pmatch (intmap-ref rel-info name)
    [(unbound) (error  'sep-fair (format "name = ~a\n" name))]
    [,args-info
    (let* ((args (sublist args-info args))
          (curr-hs (map (lambda (t) (height s t)) args)))
    (and (foldr (lambda (t acc) (or acc (is-not-free s t))) #f args)
      (pmatch (intmap-ref history name)
        [(unbound) #t]
        [,prev-hs
            (and (check-two-lists >= prev-hs curr-hs)
                 (not (check-two-lists <= prev-hs curr-hs)))])))])))

(define (sep-fair rel-info)
  (lambda (s cs)
    (let-values (((l1 l2) (split-by-pred (lambda (c) (sep-fair-pred rel-info s c)) cs)))
      (if (null? l2) (split-by-pred (lambda (c) (not (cddr c))) cs) (values l1 l2)))))

(define (to-intmap l)
  (foldl (lambda (p acc) (intmap-set acc (car p) (cadr p))) empty-intmap l))

(define (sup-fair relations)
  (let ((rel-info (to-intmap (map find-sr-args relations))))
    (list (sep-fair rel-info) (upd-fair rel-info) new-fair)))

(define (sup-fair^ rel-info)
    (list (sep-fair rel-info) (upd-fair rel-info) new-fair))

(define-syntax run-fair-internal
  (syntax-rules ()
    ((_ n rels (q0 ...) g0 ...)
      (let ((rel-info (sup-fair^ (to-intmap rels))))
        (run n rel-info (q0 ...) g0 ...)))))

(define-syntax run-fair
  (syntax-rules ()
    ((_ n rels (q0 ...) g0 ...)
      (let ((rel-info (sup-fair rels)))
        (run n rel-info (q0 ...) g0 ...)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (generate-fresh-vars scope n)
  (cond
    ((zero? n) '())
    (else (cons (var scope) (generate-fresh-vars scope (- n 1))))))

(define (get-calls stream)
  (pmatch stream
    [() '()]
    [(disj ,d1 . ,d2)
      (append (get-calls d1) (get-calls d2))]
    [(conj ,subst . ,conjs)
      (map (lambda (c) (cons subst (car c))) conjs)]))

(define (split-by-name calls name)
  (if (null? calls)
    (values '() '())
    (let-values (((l1 l2) (split-by-name (cdr calls) name)))
      (if (eq? (caadar calls) name)
        (values (cons (car calls) l1) l2)
        (values l1 (cons (caadar calls) l2))))))

(define (contains-var term var state)
  (let ((term (walk term (state-S state))))
    (cond
      ((var? term) (eq? term var))
      ((pair? term) (or (contains-var (car term) var state)
                        (contains-var (cdr term) var state)))
      (else #f))))

(define (arg-is-strict-subterm arg var state)
  (let ((arg (walk arg (state-S state))))
    (if (var? arg) #f
      (contains-var arg var state))))

(define (is-sr-argument arg vars-with-states)
  (foldr (lambda (vs acc) (and (arg-is-strict-subterm arg (cdr vs) (car vs)) acc)) #t vars-with-states))

(define (prepare-self-call c)
  (let ((state (car c))
        (args  (cddr c)))
  (map (lambda (a) (cons state a)) args)))

(define (transpose l)
  (let ((handler (lambda (x acc)
      (cons (cons (car x) (car acc)) (cons (cdr x) (cdr acc))))))
  (if (null? (car l)) '()
    (let ((res (foldr handler '(() . ()) l)))
      (cons (car res) (transpose (cdr res)))))))

(define (find-sr-args rel)
  (let* ((scope  (subst-scope (state-S empty-state)))
         (arity  (procedure-arity rel))
         (inds   (range 0 arity))
         (vars   (generate-fresh-vars scope arity))
         (call   (apply rel vars))
         (name   (caar call))
         (stream (unfold upd-unit empty-state (cons call #f)))
         (calls  (get-calls stream)))
  (let-values (((self-calls other-calls) (split-by-name calls name)))
  (let* ((prep-self-calls (map prepare-self-call self-calls))
         (groups          (transpose (cons vars prep-self-calls))))
  (list name (map (lambda (g) (is-sr-argument (car g) (cdr g))) groups))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (new-complex s c)
  `(,empty-intmap . 0))

(define (upd-complex rel-info)
  (lambda (p s c)
    (let ((name    (caaar p))
          (args    (cdar p))
          (prev    (cadr p))
          (counter (cddr p)))
    (pmatch (intmap-ref rel-info name)
      [(unbound) (error 'upd-fair (format "name = ~s\n" name))]
      [,args-info (cons (intmap-set prev name
        (map (lambda (t) (height s t)) (sublist args-info args))) (+ 1 counter))]))))

(define (sep-complex bound preds)
  (lambda (s cs)
    ; (newline) (map (lambda (c)(println (cons (caaar c) (cdar c)))) cs)
    (if (null? preds)
      (split-by-pred (lambda (c) (zero? (cddr c))) cs)
      (let-values (((l1 l2) (split-by-pred (lambda (c) (and (> bound (cddr c)) ((car preds) s c))) cs)))
        (if (null? l2) ((sep-complex bound (cdr preds)) s cs) (values l1 l2))))))


(define (sup-complex bound preds rel-info)
  (list (sep-complex bound preds) (upd-complex rel-info) new-complex))


(define (pred-struct-rec rel-info)
  (lambda (s c)
;    (println 'pred-struct-rec)
    (let ((history (cadr c))
          (name    (caaar c))
          (args    (cdar c)))
    (pmatch (intmap-ref rel-info name)
      [(unbound) (error  'sep-fair (format "name = ~a\n" name))]
      [,args-info ;(print args-info)
      (if (foldl (lambda (a b) (or a b)) #f args-info)
        (let* ((args (sublist args-info args))
              (curr-hs (map (lambda (t) (height s t)) args)))
          (and (foldr (lambda (t acc) (or acc (is-not-free s t))) #f args)
            (pmatch (intmap-ref history name)
              [(unbound) #t]
              [,prev-hs
                  (and (check-two-lists >= prev-hs curr-hs)
                       (not (check-two-lists <= prev-hs curr-hs)))])))
        #f)]))))


(define (pred-determ)
  (lambda (s c)
;    (println 'pred-determ)
    (let ((stream (unfold upd-unit s c)))
    (or (null? stream) (eq? 'conj (car stream))))))

(define (ctors-vars state term)
  (let ((t (walk term (state-S state))))
    (cond
      ((var?    t) (values 0 1))
      ((symbol? t) (values 1 0))
      ((null?   t) (values 1 0))
      ((number? t) (values 1 0))
      ((pair?   t)
        (let*-values (((ctors1 vars1) (ctors-vars state (car t)))
                      ((ctors2 vars2) (ctors-vars state (cdr t))))
          (values (+ 1 ctors1 ctors2) (+ vars1 vars2))))
      (else (error 'ctors-vars (format "term = ~s\n" t))))))

(define (ctors-vars-in-args state terms)
  (if (null? terms) (values 0 0)
    (let*-values (((ctors1 vars1) (ctors-vars-in-args state (cdr terms)))
                  ((ctors2 vars2) (ctors-vars         state (car terms))))
      (values (+ ctors1 ctors2) (+ vars1 vars2)))))

(define (pred-groundness bound)
  (lambda (s c)
;    (println 'pred-groundness)
    (let ((args (cdar c)))
      (let-values (((ctors vars) (ctors-vars-in-args s args)))
      (> (/ ctors (+ ctors vars)) bound)))))


(define-syntax run-complex
  (syntax-rules ()
    ((_ n rel-info bound preds (q0 ...) g0 ...)
      (let ((sup (sup-complex bound preds rel-info)))
            (run n sup (q0 ...) g0 ...)))))


(define-syntax run-complex1
  (syntax-rules ()
    ((_ n rels (q0 ...) g0 ...)
      (let* ((rel-info (to-intmap (map find-sr-args rels)))
             (preds    (list (pred-struct-rec rel-info)
                             (pred-determ)
                             (pred-groundness 0.7)
                             )))
      (run-complex n rel-info 10000 preds (q0 ...) g0 ...)))))


(define-syntax run-complex1-internal
  (syntax-rules ()
    ((_ n rel-info (q0 ...) g0 ...)
      (let ((preds    (list (pred-struct-rec rel-info)
                            (pred-determ)
                            (pred-groundness 0.7)
                            )))
      (run-complex n rel-info 10000 preds (q0 ...) g0 ...)))))
