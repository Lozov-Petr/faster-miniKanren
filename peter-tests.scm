(define appendo
  (cons 'appendo
    (lambda (l)
      (let ((x (car l)) (y (cadr l)) (xy (caddr l)))

  (conde (`(== ,x ()) `(== ,y ,xy))
         ((fresh (e xs xys)
          `(== ,x  (,e . ,xs))
          `(== ,xy (,e . ,xys))
          `(,appendo ,xs ,y ,xys))))))))



(define reverso
  (cons 'reverso
    (lambda (l)
      (let ((x (car l)) (y (cadr l)))

  (conde (`(== ,x ()) `(== ,y ()))
         ((fresh (e xs ys)
           `(== ,x (,e . ,xs))
           `(,appendo ,ys (,e) ,y)
           `(,reverso ,xs ,ys))))))))
