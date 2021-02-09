(load "test-check.scm")

(define (unit-sorto-4)
  (run-unit 1 (q) (sorto (list (i2n 3) (i2n 2) (i2n 1) (i2n 0)) q)))

(define term1 `(succ (,(var 1))))

(test "test1"
  (height empty-state term1)
  1)

(define term2 `(succ . zero))

(test "test2"
  (height empty-state term2)
  2)

(define "test3" `(,(var 1) ,(var 2) ,(var 3) . ,(var 4))

(test "test2"
  (height empty-state term2)
  1)
