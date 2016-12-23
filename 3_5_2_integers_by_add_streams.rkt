#lang racket

(provide cons-stream)
(define (cons-stream a b)
  (cons a (delay b)))

(provide stream-null?)
(define (stream-null? stream)
  (disln "stream-null?")
  (null? (if (procedure? stream) (force stream) stream)))

(provide the-empty-stream)
(define the-empty-stream
  '())

(provide force)
(define (force arg)
  (disln "force")
  (let ((result (if (procedure? arg) (arg) arg)))
    (if (procedure? result) (force result) result)))

(provide delay)
(define (delay proc)
  (lambda () proc))

(provide stream-car)
(define (stream-car stream)
  (let ((tmp (force stream)))
    (if (not (pair? tmp))
        tmp
        (let (( x (car (if (procedure? tmp) (force tmp) tmp))))
          (dis "stream-car: ")
          (disln x)
        (force x)))))

(provide stream-cdr)
(define (stream-cdr stream)
  (let ((tmp (force stream)))
    (if (not (pair? tmp))
        tmp
        (let (( x (cdr (if (procedure? tmp) (force tmp) tmp))))
          (dis "stream-cdr: ")
          (disln x)
        (force x)))))

(provide stream-map)
(define (stream-map proc stream)
  (disln "stream-map:")
  ;(display-stream stream)
  (if (stream-null? stream)
      '()
      (cons-stream (proc (stream-car stream))
                   (lambda() (stream-map proc (stream-cdr stream))))))

(provide multi-stream-map)
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
(provide wrong-multi-stream-map)
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

(provide add-streams-wrong-multi-stream-map)
(define (add-streams-wrong-multi-stream-map s1 s2)
  (dis "s1:") (disln s1) (dis "s2:") (disln s2)
  (wrong-multi-stream-map plus (cons-stream s1 (cons-stream s2 '()))))

(provide display-stream)
(define (display-stream s)
  (stream-for-each display-line s))

(provide stream-for-each)
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(provide display-line)
(define (display-line x) (displayln x))

(provide ones)
(define ones
  (cons-stream
   1
   (lambda() ones)))

(provide plus)
(define (plus stream)
  (define (iter stream number)
    (if (stream-null? stream)
        (begin
          (dis "plus result: ")
          (disln number)
          number)
        (iter (stream-cdr stream) (+ number (stream-car stream)))))
  (iter stream 0))

(provide integers-starting-from)
(define (integers-starting-from n)
  (if (> n 100)
      '()
      (cons-stream
       n
       (lambda() (integers-starting-from (+ n 1))))))

(provide integers)
(define integers (integers-starting-from 1))

(provide add-streams)
(define (add-streams s1 s2)
  (dis "s1:") (disln s1) (dis "s2:") (disln s2)
  (multi-stream-map plus (cons-stream s1 (cons-stream s2 '()))))


(provide stream-ref)
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (begin
        (displayln (stream-car s))
        (stream-ref (stream-cdr s) (- n 1)))))

(provide integers1)
(define (integers1)
  (disln "->integers1")
  (cons-stream
   1
   (lambda() (add-streams ones integers1))))

(provide fibs)
(define (fibs)
  (disln "->fibs")
  (cons-stream 0
               (lambda() (cons-stream 1
                                      (lambda() (add-streams (stream-cdr fibs)
                                                   fibs))))))
(provide dis)
(define (dis msg)
  (lambda() (msg))
  ;(display msg)
  )

(provide disln)
(define (disln msg)
  (lambda() (msg))
  ;(displayln msg)
  )
