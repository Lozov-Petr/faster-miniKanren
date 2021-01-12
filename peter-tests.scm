(define (to-intmap l)
  (foldl (lambda (p acc) (intmap-set acc (car p) (cdr p))) empty-intmap l))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (appendo-rel x y xy)
  (conde
    ((== x '()) (== y xy))
    ((fresh (e xs xys)
      (== x  (cons e xs))
      (== xy (cons e xys))
      (appendo xs y xys)))))

(define (appendo x y xy)
  `((appendo . ,appendo-rel) ,x ,y ,xy))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (reverso-rel x y)
  (conde
    ((== x '()) (== y '()))
    ((fresh (e xs ys)
      (== x (cons e xs))
      (appendo ys `(,e) y)
      (reverso xs ys)))))

(define (reverso x y)
  `((reverso . ,reverso-rel) ,x ,y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define rel-info1
  (to-intmap '((appendo (#t #f #t)) (reverso (#t #f)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (leo-rel x y)
  (conde
    ((== x 'zero))
    ((fresh (a b)
       (== x (cons 'succ a))
       (== y (cons 'succ b))
       (leo a b)))))

(define (leo x y)
  `((leo . ,leo-rel) ,x ,y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (gto-rel x y)
  (conde
    ((fresh (a)
      (== x (cons 'succ a))
      (== y 'zero)))
    ((fresh (a b)
      (== x (cons 'succ a))
      (== y (cons 'succ b))
      (gto a b)))))

(define (gto x y)
  `((gto . ,gto-rel) ,x ,y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (minmaxo-rel a b min max)
  (conde
    ((== min a) (== max b) (leo a b))
    ((== max a) (== min b) (gto a b))))

(define (minmaxo a b min max)
  `((minmaxo . ,minmaxo-rel) ,a ,b ,min , max))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (smallesto-rel l s l^)
  (conde
    ((== l `(,s)) (== l^ '()))
    ((fresh (h t s^ t^ max)
      (== l^ (cons max t^))
      (== l (cons h t))
      (minmaxo h s^ s max)
      (smallesto t s^ t^)))))

(define (smallesto l s l^)
  `((smallesto . ,smallesto-rel) ,l ,s ,l^))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (sorto-rel x y)
  (conde
    ((== x '()) (== y '()))
    ((fresh (s xs xs^)
      (== y (cons s xs^))
      (sorto xs xs^)
      (smallesto x s xs)))))

(define (sorto x y)
  `((sorto . ,sorto-rel) ,x ,y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (sorto^-rel x y)
  (conde
    ((== x '()) (== y '()))
    ((fresh (s xs xs^)
      (== y (cons s xs^))
      (smallesto x s xs)
      (sorto^ xs xs^)))))

(define (sorto^ x y)
  `((sorto . ,sorto^-rel) ,x ,y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define rel-info2
  (to-intmap '((leo (#t #t)) (gto (#t #t)) (minmaxo (#t #t #t #t)) (smallesto (#t #f #t)) (sorto (#f #t)))))
