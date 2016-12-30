#lang racket

(define n 0)

(define gx
  (lambda (escape)
    (begin (display "gx: escape = ") (displayln escape)
    escape)))

(define gy
  (lambda (escape)
    (begin (display "gy: escape = ") (displayln escape)
    escape)))

(define fx
  (lambda (escape)
    (display n) (newline)
    (set! n (+ n 1))
    (begin
      (displayln (format "fx: escape = ~A" escape))
      ;(set! k escape)
      escape)))

(define fy
  (lambda (escape)
    (display n) (newline)
    (set! n (+ n 1))
    (begin
      (displayln (format "fy: escape = ~A" escape))
      ;(set! k escape)
      escape)))

;((fx (call/cc gx) ) (fy (call/cc gy) ) )
;
;((call/cc bar) (foo (call/cc bar) ) )
;
(define k #f)
;(displayln "(foo (call/cc bar))") (foo (call/cc bar)  )
;(displayln "(k k)") (k k)
;(displayln "(k k)") (k k)
;(displayln "(k k)") (k k)
;(displayln "(k k)") (k k)

;(foo (call/cc bar))
;(call/cc bar) 's continuation is the (foo ...) which can be named to be foo_continuation
;the escape parameter of the bar lambda will be foo_continuation
;bar lambda will return the foo_continuation
;the returned continuation pass to the (foo ...), so the full expression should equal to (foo foo_continuation)
;the escape parameter of the foo lambda parameter will be foo_continuation.
;the full expression will execute it's body and return the escape which is the foo_continuation.
