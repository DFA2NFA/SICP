#lang racket

(define n 0)

(define bar
  (lambda (bar)
    bar))

(define foo
  (lambda (escape)
    (display n)
    (newline)
    (set! n (+ n 1))
    escape))


;(foo (call/cc bar))
;(call/cc bar) 's continuation is the (foo ...),
;so it should equal to (foo (foo 'end))


;((call/cc bar) (foo (call/cc bar)))
;(call/cc bar) 's continuation is (foo (call/cc bar)),
;so the full expresssion should be equal to
;((foo (call/cc bar)) (foo (call/cc bar)))



;(call-with-current-continuation proc)      procedure
;(call/cc proc)                             procedure
;
;Proc should accept one argument.
;The procedure call-with-current-continuation
;(which is the same as the procedure call/cc)
;packages the current continuation as an “escape procedure” and
;passes it as an argument to proc.


;((call/cc bar) (foo (call/cc bar)))

;(call/cc bar) is equal with the below lambda?
(define (ex-bar)
  (call-with-current-continuation
   (lambda (cc-bar)
     cc-bar)))

(define continuation
  (+ 1 (call-with-current-continuation
        (lambda (escape)
          (+ 2 (escape 3))))))
;=⇒ 4