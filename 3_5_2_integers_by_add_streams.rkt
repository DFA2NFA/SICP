#lang racket
(define (cons-stream a b)
  (cons a (delay b)))

(define (stream-null? stream)
  ;(displayln "stream-null?")
  (null? (if (procedure? stream) (force stream) stream)))

(define the-empty-stream
  '())

(define (force arg)
  ;(displayln "force")
  (let ((result (if (procedure? arg) (arg) arg)))
    (if (procedure? result) (force result) result)))

(define (delay proc)
  (lambda () proc))

(define (stream-car stream)
  (let ((tmp (force stream)))
    (if (not (pair? tmp))
        tmp
        (let (( x (car (if (procedure? tmp) (force tmp) tmp))))
          (display "stream-car: ")
          (displayln x)
        (force x)))))

(define (stream-cdr stream)
  (let ((tmp (force stream)))
    (if (not (pair? tmp))
        tmp
        (let (( x (cdr (if (procedure? tmp) (force tmp) tmp))))
          (display "stream-cdr: ")
          (displayln x)
        (force x)))))

(define (stream-map proc stream)
  ;(displayln "stream-map:")
  ;(display-stream stream)
  (if (stream-null? stream)
      '()
      (cons-stream (proc (stream-car stream))
                   (lambda() (stream-map proc (stream-cdr stream))))))

(define (multi-stream-map proc list-of-stream)
  (if (null? (stream-car list-of-stream))
      '()
      (cons-stream
       (proc (stream-map
              (lambda(s) (stream-car s))
              list-of-stream))
       (lambda () (multi-stream-map proc (stream-map
                                           (lambda(s) (stream-cdr s))
                                           list-of-stream))))))

(displayln "#here is a wrong-multip-stream-map,")
(displayln "#which contains one exceed () then the correct one")
(define (wrong-multi-stream-map proc list-of-stream)
  (if (null? (stream-car list-of-stream))
      '()
      (cons-stream
       (proc (stream-map
              (lambda(s) (stream-car s))
              list-of-stream))
       ((lambda () (wrong-multi-stream-map proc (stream-map
                                                 (lambda(s) (stream-cdr s))
                                                 list-of-stream)))))))

(define (add-streams-wrong-multi-stream-map s1 s2)
  (display "s1:")
  (displayln s1)
  (display "s2:")
  (displayln s2)
  (wrong-multi-stream-map plus (cons-stream s1 (cons-stream s2 '()))))

(displayln "(stream-ref (add-streams-wrong-multi-stream-map integers integers) 10)")
(displayln "#you can see, even if you only need 10 items, it go through all")
;(stream-ref (add-streams-wrong-multi-stream-map integers integers) 10)


(define (display-stream s)
  (stream-for-each display-line s))

(define (stream-for-each proc s)
  ;(display (date->string (seconds->date (current-seconds))))
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-line x) (displayln x))

(define ones
  (cons-stream
   1
   (lambda() ones)))

(define (plus stream)
  (define (iter stream number)
    (if (stream-null? stream)
        (begin
          (display "plus result: ")
          (displayln number)
          number)
        (iter (stream-cdr stream) (+ number (stream-car stream)))))
  (iter stream 0))

(define (integers-starting-from n)
  (if (> n 100)
      '()
      (cons-stream
       n
       (lambda() (integers-starting-from (+ n 1))))))

(define integers (integers-starting-from 1))

(define (add-streams s1 s2)
  (display "s1:")
  (displayln s1)
  (display "s2:")
  (displayln s2)
  (multi-stream-map plus (cons-stream s1 (cons-stream s2 '()))))

(displayln "(stream-ref (add-streams integers integers) 10)")
;(stream-ref (add-streams integers integers) 10)

(displayln "(display-stream (add-streams integers integers))")
;(display-stream (add-streams integers integers))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (begin (displayln (stream-car s)) (stream-ref (stream-cdr s) (- n 1)))))

(displayln "(stream-ref (add-streams integers integers) 10)")
;(stream-ref (add-streams integers integers) 10)

(define (integers1)
  (displayln "integers1")
  (cons-stream
   1
   (lambda() (add-streams ones integers1))))

(displayln "(stream-ref integers1 10)")
;(stream-ref integers1 10)


(displayln "(stream-ref (add-streams integers1 integers1) 10)")
;(stream-ref (add-streams integers1 integers1) 10)

(define fibs1
  (cons-stream 0
               (lambda() (cons-stream 1
                                      (lambda() (add-streams (stream-cdr fibs1)
                                                   fibs1))))))

(displayln "(stream-ref fibs1 10)")
;(stream-ref fibs1 10)

;
(define s (cons-stream 1 (lambda() (add-streams s s))))
;(stream-ref s 10)

