#lang racket
(require "3_5_1_stream_enumerate_interval.rkt")
(require "3_5_2_integers_by_add_streams.rkt")

(displayln "(display-stream (multi-stream-map plus y-stream))")
(display-stream (multi-stream-map plus y-stream))

(displayln "(display-stream (multi-stream-map plus x-stream))")
(display-stream (multi-stream-map plus x-stream))

