#lang racket
(require "3_5_2_integers_by_add_streams.rkt")
(require "3_5_1_stream_enumerate_interval.rkt")


(provide stream-accumulate)
(define (stream-accumulate op initial sequence)
  ;(newline)
  ;(displayln "#####stream-accumulate")
  (if (stream-null? sequence)
      initial
      (op (stream-car sequence)
          (stream-accumulate op initial (stream-cdr sequence)))))

(provide sum-primes-stream)
(define (sum-primes-stream a b)
  (stream-accumulate +
              0
              (stream-filter prime? (stream-enumerate-interval a b))))

(provide prime?)
(define (prime? n)
  ;(displayln "prime?")
  (= n (smallest-divisor n)))

(provide square)
(define (square x) (* x x))

(provide smallest-divisor)
(define (smallest-divisor n)
  (find-divisor n 2))

(provide find-divisor)
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(provide divides?)
(define (divides? a b)
  (= (remainder b a) 0))