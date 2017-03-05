#lang racket

;#lang planet neil/sicp 

(require rnrs/lists-6)
(require racket/trace)

(define list-sum
  (lambda (list1)
    (fold-left + 0 list1)))

(define list-sum1
  (lambda (list1)
    (if (null? list1)
        0
        (+ (car list1) (list-sum1 (cdr list1))))))

(define average
  (lambda (list1)
    (/ (list-sum1 list1) (length list1))))

;(define average-reduce
;  (lambda (list1)
;    (/ (reduce + 0 list1) (length list1))))

(define _+1
  (lambda (value)
    (+ 1 value)))

(define (fact-let n)
  (let loop((n1 n) (p n))         
    (if (= n1 1)                    
        p
        (let ((m (- n1 1)))
          (loop m (* p m)))))) 

(define (remove x ls)
  (if (null? ls)
      '()
      (let ((h (car ls)))
        ((if (eqv? x h)
             (lambda (y) y)
             (lambda (y) (cons h y)))
         (remove x (cdr ls))))))

(trace remove)


(define (replace x r ls)
  (if (null? ls)
      '()
      (let ((h (car ls)))
        ((if (eqv? x h)
             (lambda (y) (cons r y))
             (lambda (y) (cons h y)))
         (replace x r (cdr ls))))))

(trace replace)

(define my-reverse-iter
  (lambda (old-list new-list)
    (if (null? old-list)
        new-list
        (my-reverse-iter (cdr old-list) (cons (car old-list) new-list)))))

(define my-reverse
  (lambda (old-list)
    (my-reverse-iter old-list '())))

(define my-reverse-named-let
  (lambda (old-list)
    (let loop ((tmp-old-list old-list)
               (new-list '()))
      (if (null? tmp-old-list)
          new-list
          (loop (cdr tmp-old-list) (cons (car tmp-old-list) new-list))))))

(define my-locate-named-let
  (lambda (old-list x)
    (let loop ((tmp-old-list old-list) (index 0))
      (cond ((null? tmp-old-list) #f)
            ((eqv? x (car tmp-old-list)) index)
            (else (loop (cdr tmp-old-list) (+ 1 index)))))))


(define (my-string->integer str)
  (char2int (string->list str) 0))

(define (char2int ls n)
  (if (null? ls)
      n
      (char2int (cdr ls) 
                (+ (- (char->integer (car ls)) 48)
                   (* n 10)))))


(define map-proc
  (lambda (proc list1)
    (map proc list1)))
