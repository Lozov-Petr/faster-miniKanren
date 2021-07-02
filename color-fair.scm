(define (make-table-keyso-rel l t)
  (conde
    [(== l '()) (== t '())]
    [(fresh (e l^ fr t^)
      (== l `(,e . ,l^))
      (== t `((,e ,fr) . ,t^))
      (make-table-keyso l^ t^))]))

(define (make-table-keyso l t)
`((make-table-keyso . ,make-table-keyso-rel) ,l ,t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (is-coloro-rel v)
  (conde
    [(== v 'green)]
    [(== v 'blue)]
    [(== v 'red)]
    [(== v 'black)]))

(define (is-coloro v)
`((is-coloro . ,is-coloro-rel) ,v))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-table-valueso-rel t)
  (conde
    [(== t '())]
    [(fresh (e c t^)
      (== t `((,e ,c) . ,t^))
      (is-coloro c)
      (make-table-valueso t^)
      )]))

(define (make-table-valueso t)
`((make-table-valueso . ,make-table-valueso-rel) ,t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (geto-rel t k v)
  (conde
    [(fresh (t^)
      (== t `((,k ,v) . ,t^)))]
    [(fresh (k^ v^ t^)
      (=/= k  k^)
      (== t `((,k^ ,v^) . ,t^))
      (geto t^ k v))]))

(define (geto t k v)
`((geto . ,geto-rel) ,t ,k ,v))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (different-colorso-rel edges colors)
  (conde
    [(== edges '())]
    [(fresh (s1 s2 c1 c2 e)
      (== edges `((,s1 ,s2) . ,e))
      (=/= c1 c2)
      (geto colors s1 c1)
      (geto colors s2 c2)
      (different-colorso e colors))]))

(define (different-colorso edges colors)
`((different-colorso . ,different-colorso-rel) ,edges ,colors))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (coloro-rel states edges colors)
  (fresh (a)
    (make-table-keyso states colors)
    (different-colorso edges colors)
    (make-table-valueso colors)))

(define (coloro states edges colors)
`((coloro . ,coloro-rel) ,states ,edges ,colors))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define color-rels
  (list make-table-keyso is-coloro make-table-valueso geto different-colorso coloro))
