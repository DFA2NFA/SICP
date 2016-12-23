#lang racket
(require "3_5_2_integers_by_add_streams.rkt")

(displayln "Start:")
(displayln "(stream-ref (add-streams integers integers) 10)")
(stream-ref (add-streams integers integers) 10)

(displayln "(display-stream (add-streams integers integers))")
(display-stream (add-streams integers integers))


(displayln "(stream-ref (add-streams integers integers) 10)")
(stream-ref (add-streams integers integers) 10)


(displayln "(stream-ref integers1 10)")
(stream-ref integers1 10)


(displayln "(stream-ref (add-streams integers1 integers1) 10)")
(stream-ref (add-streams integers1 integers1) 10)


(displayln "(stream-ref fibs 10)")
(stream-ref fibs 10)

(displayln "(define s (cons-stream 1 (lambda() (add-streams s s))))")
(define s (cons-stream 1 (lambda() (add-streams s s))))
(displayln "(stream-ref s 10)")
(stream-ref s 10)

(displayln "(stream-ref (add-streams-wrong-multi-stream-map integers integers) 10)")
(displayln "#you can see, even if you only need 10 items, it go through all")
(displayln "#you can open the dis to print the log")
(stream-ref (add-streams-wrong-multi-stream-map integers integers) 10)