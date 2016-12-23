#lang racket
(require "3_5_2_integers_by_add_streams.rkt")

(provide divisible?)
(define (divisible? x y)
  (= (remainder x y) 0))

(provide not-seven)
(define (not-seven n)
  (not (divisible? n 7)))

(provide stream-filter)
(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (lambda () (stream-filter pred
                                     (stream-cdr stream)))))
        (else (stream-filter pred (stream-cdr stream)))))

(provide no-sevens)
(define no-sevens
  (stream-filter not-seven integers))

(provide fibgen)
(define (fibgen a b)
  (cons-stream
   a
   (lambda() (fibgen b (+ a b)))))

(provide fibs2)
(define fibs2 (fibgen 0 1))

(provide sieve)
(define (sieve stream)
  (if (stream-null? stream) '()
  (cons-stream
   (stream-car stream)
   (lambda() (sieve (stream-filter
           (lambda (x)
             (not (divisible? x (stream-car stream))))
           (stream-cdr stream)))))))

(provide primes)
(define primes
  (sieve (integers-starting-from 2)))

(provide show)
(define (show x)
  (display-line x)
  x)
