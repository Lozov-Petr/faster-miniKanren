(define (make-table-keyso l t)
  (conde
    [(== l '()) (== t '())]
    [(fresh (e l^ fr t^)
      (== l `(,e . ,l^))
      (== t `((,e ,fr) . ,t^))
      (make-table-keyso l^ t^))]))

(define (is-coloro v)
  (conde
    [(== v 'green)]
    [(== v 'blue)]
    [(== v 'red)]
    [(== v 'black)]))

(define (make-table-valueso t)
  (conde
    [(== t '())]
    [(fresh (e c t^)
      (== t `((,e ,c) . ,t^))
      (make-table-valueso t^)
      (is-coloro c)
      )]))

(define (geto t k v)
  (conde
    [(fresh (t^)
      (== t `((,k ,v) . ,t^)))]
    [(fresh (k^ v^ t^)
      (=/= k  k^)
      (== t `((,k^ ,v^) . ,t^))
      (geto t^ k v))]))

(define (different-colorso edges colors)
  (conde
    [(== edges '())]
    [(fresh (s1 s2 c1 c2 e)
      (== edges `((,s1 ,s2) . ,e))
      (=/= c1 c2)
      (geto colors s1 c1)
      (geto colors s2 c2)
      (different-colorso e colors))]))

(define (coloro states edges colors)
  (fresh (a)
    (make-table-keyso states colors)
    (different-colorso edges colors)
    (make-table-valueso colors)))
