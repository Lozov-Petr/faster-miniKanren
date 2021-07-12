#lang racket/base

(require racket/list
         racket/include)

(provide run run*
         == =/=
         fresh
         conde
         symbolo numbero stringo
         absento
         project
         var? var
         always-wrap-reified?
         empty-state
         goal-to-stream
         unfold step
         split-by-pred
         new-unit
         upd-unit
         sep-unit
         new-fair
         upd-fair
         sep-fair
         run-unit
         run-fair run-fair-internal to-intmap
         init-state height
         sublist
         find-sr-args
         lengtho check-listo repeato

         pred-struct-rec
         pred-determ
         pred-groundness
         find-sr-args
         run-complex
         run-complex1
         run-complex1-internal)

(define empty-intmap (hasheq))
(define (intmap-count m) (hash-count m))
(define (intmap-ref m k) (hash-ref m k (lambda () unbound)))
(define (intmap-set m k v) (hash-set m k v))

;; extra stuff for racket
;; due mostly to samth
(define (list-sort f l) (sort l f))

(define (remp f l) (filter-not f l))

(define (call-with-string-output-port f)
  (define p (open-output-string))
  (f p)
  (get-output-string p))

(define (exists f l) (ormap f l))

(define for-all andmap)

(define (find f l)
  (cond [(memf f l) => car] [else #f]))

(define memp memf)

(define (var*? v) (var? (car v)))

(include "mk.scm")
(include "pmatch.scm")
(include "fair.scm")
(include "test-check.scm")
(include "peter-tests.scm")
