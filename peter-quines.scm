(define eval-expo-rel
  (lambda (exp env val)
    (conde
      ((fresh (v)
         (== `(quote ,v) exp)
         (not-in-envo 'quote env)
         (absento 'closure v)
         (== v val)))
      ((fresh (a*)
         (== `(list . ,a*) exp)
         (not-in-envo 'list env)
         (absento 'closure a*)
         (proper-listo a* env val)))
      ((symbolo exp) (lookupo exp env val))
      ((fresh (rator rand x body env^ a)
         (== `(,rator ,rand) exp)
         (eval-expo rator env `(closure ,x ,body ,env^))
         (eval-expo rand env a)
         (eval-expo body `((,x . ,a) . ,env^) val)))
      ((fresh (x body)
         (== `(lambda (,x) ,body) exp)
         (symbolo x)
         (not-in-envo 'lambda env)
         (== `(closure ,x ,body ,env) val))))))

(define (eval-expo exp env val)
  `((eval-expo . ,eval-expo-rel) ,exp ,env ,val))

(define not-in-envo-rel
  (lambda (x env)
    (conde
      ((fresh (y v rest)
         (== `((,y . ,v) . ,rest) env)
         (=/= y x)
         (not-in-envo x rest)))
      ((== '() env)))))

(define (not-in-envo x env)
  `((not-in-envo . ,not-in-envo-rel) ,x ,env))

(define proper-listo-rel
  (lambda (exp env val)
    (conde
      ((== '() exp)
       (== '() val))
      ((fresh (a d t-a t-d)
         (== `(,a . ,d) exp)
         (== `(,t-a . ,t-d) val)
         (eval-expo a env t-a)
         (proper-listo d env t-d))))))

(define (proper-listo exp env val)
  `((proper-listo . ,proper-listo-rel) ,exp ,env ,val))

(define lookupo-rel
  (lambda (x env t)
    (fresh (rest y v)
      (== `((,y . ,v) . ,rest) env)
      (conde
        ((== y x) (== v t))
        ((=/= y x) (lookupo x rest t))))))

(define (lookupo x env t)
  `((lookupo . ,lookupo-rel) ,x ,env ,t))

(define quine-rels
  (list
   eval-expo
   not-in-envo
   proper-listo
   lookupo))


(define quines-info (to-intmap
  '((eval-expo (#t #f #f))
    (not-in-envo (#f #t))
    (proper-listo (#t #f #t))
    (lookupo (#f #t #f)))))
