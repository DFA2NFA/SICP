#lang racket


(define (ShowAllUnicode)
  (define (iter index)
    (cond
      [(and (>= index #xd800) (< index #xe000)) (iter (+ 1 index))]
      [(> index #x10ffff) (print ".done!")]
      [else (begin (print (integer->char index)) (iter (+ 1 index)) )]))
  (iter 0))

    