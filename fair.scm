(define-syntax conjs
  (syntax-rules ()
    ((_ g) g)
    ((_ g1 g2 g ...) (conjs `(&& ,g1 ,g2) g ...))))


(define-syntax fresh
  (syntax-rules ()
    ((_ (x ...) g ...)
      (lambda (st)
          (let ((scope (subst-scope (state-S st))))
            (let ((x (var scope)) ...)
              (conjs g ...)))))))


(define-syntax disjs
  (syntax-rules ()
    ((_ g) g)
    ((_ g1 g2 g ...) (disjs `(|| ,g1 ,g2) g ...))))


 (define-syntax conde
   (syntax-rules ()
     ((_ (g0 ...) (g1 ...) ...)
      (lambda (st)
        (let ((st (state-with-scope st (new-scope))))
          (disjs
              (conjs g0 ...)
              (conjs g1 ...) ...))))))


(define (disj-cmb stream1 stream2)
  (cond
    ((null? stream1) stream2)
    ((null? stream2) stream1)
    (else `(disj ,stream1 ,stream2))))


(define (goal-to-stream upd subst goal)
  (letrec ((g2s
    (lambda (stream goal)
      (cond

        ((null? goal)
          (error "Goal is null."))

        ((null? stream)
          stream)

        ((eq? 'disj (car stream))
          (let ((d1 (cadr stream))
                (d2 (caddr stream)))
          (print "disj stream?")
          (newline)
          (disj-cmb (g2s d1 goal) (g2s d2 goal))))

        ((procedure? goal)
          (let ((subst (cadr stream)))
          (print "procedure?")
          (newline)
          (g2s stream (goal subst))))

        ((eq? '== (car goal))
          (let ((t1 (cadr goal))
                (t2 (caddr goal))
                (subst (cadr stream))
                (conjs (cddr stream)))
          (let ((new-state ((== t1 t2) subst)))
            (print "uni?")
            (newline)
            (if new-state `(conj ,new-state ,conjs) '()))))

        ((eq? '&& (car goal))
          (let ((c1 (cadr goal))
                (c2 (caddr goal)))
          (print "conj goal?")
          (newline)
          (g2s (g2s stream c1) c2)))

        ((eq? '|| (car goal))
          (let ((d1 (cadr goal))
                (d2 (caddr goal)))
          (print "disj goal?")
          (newline)
          (disj-cmb (g2s stream d1) (g2s stream d2))))

        (else
          (let ((subst (cadr stream))
                (conjs (cddr stream)))
          (print "invoke?")
          (newline)
          `(conj ,subst ,(append conjs (list (list goal (upd subst goal)))))))))))
    (g2s `(conj ,subst ()) goal)))


(define (upd-unit s c) #f)
