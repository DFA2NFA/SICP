#lang racket
(require "3_5_1_stream_accumulate.rkt")
(require "3_5_2_integers_by_add_streams.rkt")
(require "3_5_2_infinity_stream.rkt")
(require "3_5_1_stream_enumerate_interval.rkt")

;3.51
(displayln "3.51")
(define x
  (stream-map show (stream-enumerate-interval 0 10)))

(displayln "(stream-ref x 5)")
(stream-ref x 5)

(displayln "(stream-ref x 7)")
(stream-ref x 7)

;3.52
(displayln "3.52")

(provide accum)
(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))

(displayln "3.52-sum-even-y")
(define sum-even-y
  (stream-filter even? seq))

(displayln "3.52-sum-remainder-5-z")
(define sum-remainder-5-z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))

(displayln "(stream-ref sum-even-y 7)")
(stream-ref sum-even-y 7)

(displayln "(display-stream sum-remainder-5-z)")
(display-stream sum-remainder-5-z)

;3.50
;3.51
;0
;(stream-ref x 5)
;0
;1
;1
;2
;2
;3
;3
;4
;4
;5
;5
;(stream-ref x 7)
;0
;1
;1
;2
;2
;3
;3
;4
;4
;5
;5
;6
;6
;7
;7
;3.52
;3.52-sum-even-y
;3.52-sum-remainder-5-z
;(stream-ref sum-even-y 7)
;6
;24
;30
;54
;64
;100
;114
;162
;(display-stream sum-remainder-5-z)
;15
;180
;230
;305
;'done