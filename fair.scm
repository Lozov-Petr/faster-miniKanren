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


(define (disj-cmb stream1 stream2)
  (cond
    ((null? stream1) stream2)
    ((null? stream2) stream1)
    (else `(disj ,stream1 . ,stream2))))


(define (goal-to-stream upd state goal)
  (letrec ((g2s
    (lambda (stream goal)
      (cond

        ((null? goal)
          (error "Goal is null."))

        ((null? stream)
          stream)

        ((eq? 'disj (car stream))
          (let ((d1 (cadr stream))
                (d2 (cddr stream)))
          (disj-cmb (g2s d1 goal) (g2s d2 goal))))

        ((procedure? goal)
          (let ((state (cadr stream))
                (conjs (cddr stream)))
          (let-values (((goal state) (goal state)))
            (g2s `(conj ,state . ,conjs) goal))))

        ((eq? '== (car goal))
          (let ((t1 (cadr goal))
                (t2 (caddr goal))
                (state (cadr stream))
                (conjs (cddr stream)))
          (let ((new-state ((== t1 t2) state)))
            (if new-state `(conj ,new-state . ,conjs) '()))))

        ((eq? '&& (car goal))
          (let ((c1 (cadr goal))
                (c2 (cddr goal)))
          (g2s (g2s stream c1) c2)))

        ((eq? '|| (car goal))
          (let ((d1 (cadr goal))
                (d2 (cddr goal)))
          (disj-cmb (g2s stream d1) (g2s stream d2))))

        (else
          (let ((state (cadr stream))
                (conjs (cddr stream)))
          `(conj ,state . ,(append conjs (list (list goal (upd state goal)))))))))))
    (g2s `(conj ,state . ()) goal)))


(define (unfold upd state call)
  (let ((relation  (cdaar call))
        (arguments (cdar call))
        (upd       (lambda (s c) (upd call s c))))
        (goal-to-stream upd state (relation arguments))))


(define (push conjs1 conjs2 stream)
  (cond
    ((null? stream) stream)
    ((eq? 'disj (car stream))
      (let ((d1 (cadr stream))
            (d2 (cddr stream)))
      `(disj ,(push conjs1 conjs2 d1) . ,(push conjs1 conjs2 d2))))
    ((eq? 'conj (car stream))
      (let ((state (cadr stream))
            (conjs (cddr stream)))
      `(conj ,state . ,(append conjs1 (append conjs conjs2)))))))


(define (split-by-pred pred list)
  (cond
    ((null? list) (values '() '()))
    (else (if (pred (car list))
      (values '() list)
      (let-values (((list1 list2) (split-by-pred pred (cdr list))))
        (values (cons (car list) list1) list2))))))


(define (step pred upd new stream)
  (cond
    ((eq? 'disj (car stream))
      (let ((d1 (cadr stream))
            (d2 (cddr stream)))
      (let-values (((d1 answer) (step pred upd new d1)))
        (values (disj-cmb d2 d1) answer))))
    ((eq? 'conj (car stream))
      (let ((state (cadr stream))
            (conjs (cddr stream)))
      (if (null? conjs) (values '() state)
      (let-values (((conjs1 conjs2)
                    (split-by-pred (lambda (c) (pred state c)) conjs)))
             (cond
               ((null? conjs2)
                 (step pred upd new
                       `(conj ,state . ,(map (lambda (c) ((car c) . (new state c))) conjs))))
               (else
                 (values (push conjs1 (cdr conjs2) (unfold upd state (car conjs2))) #f)))))))))


(define (init-state new goal)
  (goal-to-stream new empty-state goal))


(define (run n pred upd new goal)
  (letrec ((run^ (lambda (n stream)
    (if (zero? n) '()
    (let-values (((stream answer) (step pred upd new stream)))
     (if (null? stream)
       (if answer `(,answer) '())
       (if answer
        (cons answer (run^ (if n (- n 1) n) stream))
        (run^ n stream))))))))
  (run^ n (init-state new goal))))

(define (upd-unit p s c) #f)
(define (new-unit s c) #f)
(define (pred-unit s c) #t)
(define (step-unit stream) (step pred-unit upd-unit new-unit stream))
(define (run-unit n stream) (run n pred-unit upd-unit new-unit stream))
