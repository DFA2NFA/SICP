#lang racket
(require "3_5_2_infinity_stream.rkt")
(require "3_5_2_integers_by_add_streams.rkt")

(displayln "(stream-ref no-sevens 10)")
(stream-ref no-sevens 10)

(displayln "(stream-ref fibs2 10)")
(stream-ref fibs2 10)

(displayln "display-stream fibs")
;(display-stream fibs)

(displayln "(stream-ref primes 10)")
(stream-ref primes 10)

(displayln "(display-stream primes)")
;(display-stream primes)