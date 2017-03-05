#lang racket
(require racket/vector)
;;;;;;
(define (ucar n)
  (if (null? n)
      '()
      (car n)))

(define (ucdr n)
  (if (null? n)
      '()
      (cdr n)))

;point-dir
;(list (cons h l) (list dir1 dir2 dir3 dir4))
(define maze-map (vector 0 1 1 1 0 1 1 0
                         0 0 0 1 0 0 0 0
                         0 1 0 0 0 1 0 1
                         0 1 0 1 0 1 0 1
                         1 1 0 1 0 1 0 1
                         0 0 0 1 1 0 0 0
                         1 1 1 1 1 0 1 1 
                         0 0 0 0 0 0 0 1
                         )) 
(define maze-size 8)
(define n maze-size)
(define m maze-size)
(define start-point (cons 0 0))
(define end-point (cons (sub1 n) 0))
(define init-dir '(rt up dn lt))
(define dir-table (list (cons 'up '(up lt rt dn))
                        (cons 'dn '(dn lt rt up))
                        (cons 'lt '(up dn lt rt))
                        (cons 'rt '(up dn rt lt))))
(define (make-pd point dir)
  (list point dir))

(define (get-point pd)
  (ucar pd))

(define (get-dir pd)
  (cadr pd))

(define s-pd (make-pd start-point init-dir))
(define e-pd (make-pd end-point init-dir))

;;;;;
(define trace-map '())
(define (push-tm pd)
  (set! trace-map (cons pd trace-map)))
(define (pop-tm)
  (let ((temp (ucar trace-map)))
    (set! trace-map (ucdr trace-map))
    temp))
(define (read-tm)
  (ucar trace-map))
;;;;;
(define (go-maze s-pd e-pd)
  (let* ((s-point (get-point s-pd))
         (s-dir (get-dir s-pd))
         (e-point (get-point e-pd))
         (e-dir (get-dir e-pd))
         (init-dir (ucar s-dir)))
    (define (take-next-dir dir)
      (cond ((null? dir) '())
            (else
             (ucdr (assoc dir dir-table)))))
    (define (take-next-point point dir)
      (let ((n (ucar point))
            (m (ucdr point)))
        (case dir
          ((up) (cons (sub1 n) m))
          ((dn) (cons (add1 n) m))
          ((lt) (cons n (sub1 m)))
          ((rt) (cons n (add1 m)))
          (else
           (error "no this dir!!" dir)))))
    (define (reverse-dir dir)
      (case dir
        ((up) 'dn)
        ((dn) 'up)
        ((lt) 'rt)
        ((rt) 'lt)
        (else (error "Error dir!!" dir))))
    (define (display-map point)
      (let ((temp (read-maze-point point)))
        (set-maze-point! point 'N)
        (let loop ((n 0) 
                   (c maze-size))
          (cond ((< n c)
                 (displayln (vector-copy maze-map (* n c) (+ (* n c) m)))
                 (loop (add1 n) c))
                (else
                 (displayln point)
                 ;(displayln trace-map)
                 (displayln "******End*******"))))
        (set-maze-point! point temp))) 
    (define (read-maze-point point)
      (let ((hang (ucar point)) 
            (lie (ucdr point))
            (n maze-size))
        (cond ((or (not (number? hang))
                   (not (number? lie))
                   (< hang 0) (>= hang maze-size)
                   (< lie 0) (>= lie maze-size))
               #f)
              (else
               (vector-ref maze-map (+ (* hang n) lie))))))
    (define (set-maze-point! point flag)
      (let ((hang (ucar point)) 
            (lie (ucdr point)))
        (cond ((or (not (number? hang))
                   (not (number? lie))
                   (< hang 0) (>= hang maze-size)
                   (< lie 0) (>= lie maze-size))
               #f)
              (else 
               (vector-set! maze-map (+ (* hang maze-size) lie) flag)))))
    ;;
    (define (display-tm)
      trace-map)
    ;;
    (define (can-use? point)
      (equal? (read-maze-point point) 0))
    ;;
    (define (set-point-flag! point flag)
      (set-maze-point! point flag))
    ;;
    (define (save-pd-tm pd)
      (push-tm pd))
    ;;
    (define (go-again? point)
      (equal? (read-maze-point point) 'G))
    ;;
    (define (is-wall? point)
      (let ((result (read-maze-point point)))
        (or (eq? result #f)
            (equal? (read-maze-point point) 1))))
    ;;
    (define (display-tm-point t-p)
      (cond ((null? t-p) '())
            (else
             (cons (caar t-p)
                   (display-tm-point (cdr t-p))))))
    (define (go-maze-p point dir)
      ;(displayln (list point (display-tm)))
      (cond ((equal? point e-point)
             (displayln "Congratulations!")
             (display-map point)
             (reverse (display-tm-point trace-map)))
            ((can-use? point)
             (display-map point)
             (set-point-flag! point 'G)
             (let* ((temp-dir (ucar dir))
                    (rest-dir (ucdr dir))
                    (next-dir (take-next-dir temp-dir))
                    (next-point (take-next-point point temp-dir)))
               (save-pd-tm (make-pd point rest-dir))
               (go-maze-p next-point next-dir)))
            ((go-again? point)
             (let* ((dir (get-dir (pop-tm)))
                    (temp-dir (ucar dir))
                    (rest-dir (ucdr dir))
                    (next-dir (take-next-dir temp-dir))
                    (next-point (take-next-point point temp-dir)))
               (if (null? rest-dir)
                   (set-point-flag! point 'B)
                   (save-pd-tm (make-pd point rest-dir)))
               (go-maze-p next-point next-dir)))
            ;;;;;;墙或不可用的点
            ((is-wall? point)
             (let* ((temp-dir (list-ref dir 3))
                    (next-dir (take-next-dir temp-dir))
                    (next-point (take-next-point point temp-dir)))
               (go-maze-p next-point next-dir)))
            (else 
             (displayln "Oh My God!!!"))))
    (go-maze-p s-point s-dir)))
;;;;;;


;;;;;;
;test
(go-maze s-pd e-pd)