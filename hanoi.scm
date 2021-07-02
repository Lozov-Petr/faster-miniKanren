(define (extrao move pin)
  (conde
    ((conde ((== move '(A . B))) ((== move '(B . A)))) (== pin 'C))
    ((conde ((== move '(A . C))) ((== move '(C . A)))) (== pin 'B))
    ((conde ((== move '(B . C))) ((== move '(C . B)))) (== pin 'A))))

(define (selecto set pin r)
  (fresh (x y z)
    (== set `(,x ,y . ,z))
    (conde
      ((== pin 'A) (== r x))
      ((== pin 'B) (== r y))
      ((== pin 'C) (== r z)))))

(define (permuto move set set^)
  (fresh (e a^ b^ c^ a b)
    (== move `(,a . ,b))
    (extrao move e)
    (selecto set e c^)
    (selecto set a a^)
    (selecto set b b^)
    (== set^ `(,a^ ,b^ . ,c^))))

(define (tumrepo move set set^)
  (fresh (a^ b^ c^)
    (== set `(,a^ ,b^ . ,c^))
    (conde
      ((== move '(A . B)) (== set^ `(,a^ ,b^ . ,c^)))
      ((== move '(B . A)) (== set^ `(,b^ ,a^ . ,c^)))
      ((== move '(A . C)) (== set^ `(,a^ ,c^ . ,b^)))
      ((== move '(C . A)) (== set^ `(,b^ ,c^ . ,a^)))
      ((== move '(B . C)) (== set^ `(,c^ ,a^ . ,b^)))
      ((== move '(C . B)) (== set^ `(,c^ ,b^ . ,a^))))))

(define (less a b)
  (fresh (b^)
    (== b `(s . ,b^))
    (conde
      ((== a 'o))
      ((fresh (a^)
        (== a `(s . ,a^))
        (less a^ b^))))))

(define (evalo p set set^)
  (conde
    ((== p '()) (== set set^))
    ((fresh (a p^)
      (== p `((,a . ,a) . ,p^))
      (evalo p^ set set^)))
    ((fresh (move a b p^ setp onA onB onC setp^ setp^^ topA restA)
      (== p `(,move . ,p^))
      (== move `(,a . ,b))
      (permuto move set setp)
      (== setp `(,onA ,onB . ,onC))
      (== onA `(,topA . ,restA))
      (conde
        ((== onB '()) (== setp^ `(,restA (,topA) . ,onC)))
        ((fresh (topB restB)
          (== onB `(,topB . ,restB))
          (less topA topB)
          (== setp^ `(,restA (,topA . ,onB) . ,onC)))))
      (tumrepo move setp^ setp^^)
      (evalo p^ setp^^ set^)))))

(define (lengtho l n)
  (conde
    ((== l '()) (== n 'o))
    ((fresh (e l^ n^)
      (== l `(,e . ,l^))
      (== n `(s . ,n^))
      (lengtho l^ n^)))))

(define (int2nat i)
  (if (= i 0) 'o `(s . ,(int2nat (- i 1)))))

(define (gen_pin i)
  (if (= i 0) '() `(,(int2nat (- i 1)) . ,(gen_pin (- i 1)))))

(define (start_set i)
  `(,(reverse (gen_pin i)) () . ()))

(define (finish_set i)
  `(() () . ,(reverse (gen_pin i))))

(define (int_evalo p i)
  (evalo p (start_set i) (finish_set i)))
