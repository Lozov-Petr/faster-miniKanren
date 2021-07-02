(load "test-check.scm")
(load "color-fair.scm")
(load "hanoi-fair.scm")
(load "peter-tests.scm")
(load "peter-numbers.scm")
(load "peter-quines.scm")


; (time (test "test"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-determ)
;                          (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso-unit-1"
;   (run-unit -1 (q) (reverso (range 100) q))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

; (time (test "reverso-unit-2"
;   (run-unit -1 (q) (reverso q (range 100)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-unit-3"
;   (run-unit -1 (q) (reverso^ (range 100) q))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-unit-4"
;   (run-unit -1 (q) (reverso^ q (range 100)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso1-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso1-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso1-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso1-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso2-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso2-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso2-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso2-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso3-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.6)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

; (time (test "reverso3-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.6)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso3-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.6)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

; (time (test "reverso3-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.6)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso4-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso4-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso4-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso4-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso5-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso5-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso5-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso5-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso6-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.9)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso6-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.9)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso6-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.9)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso6-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 0.9)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso7-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 1)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso7-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 1)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso7-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 1)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

; (time (test "reverso7-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-groundness 1)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso-complex1-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-determ)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex1-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-determ)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex1-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-determ)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex1-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-determ)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso-complex2-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex2-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex2-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex2-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso-complex3-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          (pred-groundness 0.8)
;                          (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex3-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          (pred-groundness 0.8)
;                          (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex3-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          (pred-groundness 0.8)
;                          (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex3-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-determ)
;                          (pred-groundness 0.8)
;                          (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "reverso-complex4-1"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex4-2"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex4-3"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ (range 100) q)))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))
;
; (time (test "reverso-complex3-4"
;   (let* ((rel-info (to-intmap (map find-sr-args reverso-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (reverso^ q (range 100))))
;   '((99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto-unit-1"
;   (run-unit 1 (q) (sorto (rev-list 20) q))
;   '()))
;
; (time (test "sorto-unit-2"
;   (run-unit -1 (q) (sorto q (sort-list 4)))
;   '()))
;
; (time (test "sorto-unit-3"
;   (run-unit -1 (q) (sorto^ (rev-list 20) q))
;   '()))
;
; (time (test "sorto-unit-4"
;   (run-unit -1 (q) (sorto^ q (sort-list 4)))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto1-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))
;
; (time (test "sorto1-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto1-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))
;
; (time (test "sorto1-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto2-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))
;
; (time (test "sorto2-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto2-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))
;
; (time (test "sorto2-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-determ)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto3-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.6)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))

; (time (test "sorto3-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.6)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto3-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.6)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))

; (time (test "sorto3-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.6)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto4-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))

; (time (test "sorto4-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto4-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))

; (time (test "sorto4-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.7)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto5-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))
;
; (time (test "sorto5-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto5-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))
;
; (time (test "sorto5-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto6-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.9)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))
;
; (time (test "sorto6-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.9)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto6-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.9)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))
;
; (time (test "sorto6-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 0.9)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto7-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 1)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))

; (time (test "sorto7-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 1)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto7-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 1)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))

; (time (test "sorto7-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-groundness 1)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto-complex1-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-struct-rec rel-info)
;                          (pred-determ)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))
;
; (time (test "sorto-complex1-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-struct-rec rel-info)
;                   (pred-determ)
;                   (pred-groundness 0.8)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto-complex1-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-struct-rec rel-info)
;                   (pred-determ)
;                   (pred-groundness 0.8)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))
;
; (time (test "sorto-complex1-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-struct-rec rel-info)
;                   (pred-determ)
;                   (pred-groundness 0.8)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto-complex2-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-determ)
;                          (pred-struct-rec rel-info)
;                          (pred-groundness 0.8)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))

; (time (test "sorto-complex2-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-determ)
;                   (pred-struct-rec rel-info)
;                   (pred-groundness 0.8)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto-complex2-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-determ)
;                   (pred-struct-rec rel-info)
;                   (pred-groundness 0.8)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))

; (time (test "sorto-complex2-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-determ)
;                   (pred-struct-rec rel-info)
;                   (pred-groundness 0.8)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "sorto-complex3-1"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;          (preds    (list (pred-determ)
;                          (pred-groundness 0.8)
;                          (pred-struct-rec rel-info)
;                          )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
;   '()))

; (time (test "sorto-complex3-2"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-determ)
;                   (pred-groundness 0.8)
;                   (pred-struct-rec rel-info)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
;   '()))
;
; (time (test "sorto-complex3-3"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-determ)
;                   (pred-groundness 0.8)
;                   (pred-struct-rec rel-info)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
;   '()))

; (time (test "sorto-complex3-4"
;   (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
;   (preds    (list (pred-determ)
;                   (pred-groundness 0.8)
;                   (pred-struct-rec rel-info)
;                   )))
;   (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
;   '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(time (test "sorto-complex4-1"
  (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
         (preds    (list (pred-struct-rec rel-info)
                         (pred-groundness 0.8)
                         (pred-determ)
                         )))
  (run-complex -1 rel-info 10000 preds (q) (sorto (rev-list 20) q)))
  '()))

(time (test "sorto-complex4-2"
  (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
  (preds    (list (pred-struct-rec rel-info)
                  (pred-groundness 0.8)
                  (pred-determ)
                  )))
  (run-complex -1 rel-info 10000 preds (q) (sorto q (sort-list 4))))
  '()))

(time (test "sorto-complex4-3"
  (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
  (preds    (list (pred-struct-rec rel-info)
                  (pred-groundness 0.8)
                  (pred-determ)
                  )))
  (run-complex -1 rel-info 10000 preds (q) (sorto^ (rev-list 20) q)))
  '()))

(time (test "sorto-complex4-4"
  (let* ((rel-info (to-intmap (map find-sr-args sorto-rels)))
  (preds    (list (pred-struct-rec rel-info)
                  (pred-groundness 0.8)
                  (pred-determ)
                  )))
  (run-complex -1 rel-info 10000 preds (q) (sorto^ q (sort-list 4))))
  '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "quine-unit-1"
;   (run-unit 1 (q) (eval-expo q '() q))
;   '((((lambda (_.0) (list _.0 (list (quote quote) _.0))) (quote (lambda (_.0) (list _.0 (list (quote quote) _.0))))) (=/= ((_.0 closure)) ((_.0 list)) ((_.0 quote))) (sym _.0)))))

; (time (test "quine-unit-2"
;   (run-unit 2 (q) (eval-expo q '() q))
;   '((((lambda (_.0) (list _.0 (list (quote quote) _.0))) (quote (lambda (_.0) (list _.0 (list (quote quote) _.0))))) (=/= ((_.0 closure)) ((_.0 list)) ((_.0 quote))) (sym _.0)) (((lambda (_.0) (list _.0 (list (quote quote) ((lambda (_.1) _.0) (lambda (_.2) _.3))))) (quote (lambda (_.0) (list _.0 (list (quote quote) ((lambda (_.1) _.0) (lambda (_.2) _.3))))))) (=/= ((_.0 _.1)) ((_.0 closure)) ((_.0 lambda)) ((_.0 list)) ((_.0 quote)) ((_.1 closure)) ((_.2 closure))) (sym _.0 _.1 _.2) (absento (closure _.3))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "quine-quasi-1"
;   (let* ((preds (list (pred-struct-rec quines-info)
;                   )))
;   (run-complex 1 quines-info 10000 preds (q) (eval-expo q '() q)))
;   '((((lambda (_.0) (list _.0 (list (quote quote) _.0))) (quote (lambda (_.0) (list _.0 (list (quote quote) _.0))))) (=/= ((_.0 closure)) ((_.0 list)) ((_.0 quote))) (sym _.0)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (time (test "quine-complex1-1"
;   (let* ((preds (list (pred-struct-rec quines-info)
;                       (pred-determ)
;                       (pred-groundness 0.8)
;                   )))
;   (run-complex 1 quines-info 10000 preds (q) (eval-expo q '() q)))
;   '((((lambda (_.0) (list _.0 (list (quote quote) _.0))) (quote (lambda (_.0) (list _.0 (list (quote quote) _.0))))) (=/= ((_.0 closure)) ((_.0 list)) ((_.0 quote))) (sym _.0)))))
;
; (time (test "quine-complex2-1"
;   (let* ((preds (list (pred-determ)
;                       (pred-struct-rec quines-info)
;                       (pred-groundness 0.8)
;                   )))
;   (run-complex 1 quines-info 10000 preds (q) (eval-expo q '() q)))
;   '((((lambda (_.0) (list _.0 (list (quote quote) _.0))) (quote (lambda (_.0) (list _.0 (list (quote quote) _.0))))) (=/= ((_.0 closure)) ((_.0 list)) ((_.0 quote))) (sym _.0)))))

; (time (test "quine-complex3-1"
;   (let* ((preds (list (pred-determ)
;                       (pred-groundness 0.8)
;                       (pred-struct-rec quines-info)
;                   )))
;   (run-complex 1 quines-info 10000 preds (q) (eval-expo q '() q)))
;   '((((lambda (_.0) (list _.0 (list (quote quote) _.0))) (quote (lambda (_.0) (list _.0 (list (quote quote) _.0))))) (=/= ((_.0 closure)) ((_.0 list)) ((_.0 quote))) (sym _.0)))))

; (time (test "quine-complex4-1"
;   (let* ((preds (list (pred-struct-rec quines-info)
;                       (pred-groundness 0.8)
;                       (pred-determ)
;                   )))
;   (run-complex 1 quines-info 10000 preds (q) (eval-expo q '() q)))
;   '((((lambda (_.0) (list _.0 (list (quote quote) _.0))) (quote (lambda (_.0) (list _.0 (list (quote quote) _.0))))) (=/= ((_.0 closure)) ((_.0 list)) ((_.0 quote))) (sym _.0)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
