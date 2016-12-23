#lang racket
(require "3_5_2_integers_by_add_streams.rkt")

(provide stream-enumerate-interval)
(define (stream-enumerate-interval low high)
  (dis "stream-enumerate-interval: low:") (dis low) (dis ", high: ") (disln high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (lambda () (stream-enumerate-interval (+ low 1) high)))))

(displayln "3.50")
(provide one_to_ten)
(define one_to_ten
  (stream-enumerate-interval 1 8))

(provide y-stream)
(define y-stream
  (cons-stream
   one_to_ten
   (cons-stream
    one_to_ten
    (cons-stream one_to_ten '()))))

(define stream1 (cons 1 (cons 2 (cons 3 '()))))
(define stream2 (cons 4 (cons 5 (cons 6 '()))))
(define stream3 (cons 7 (cons 8 (cons 9 '()))))


(provide x-stream)
(define x-stream
  (cons-stream
   stream1
   (cons-stream
    stream2
    (cons-stream stream3 '()))))