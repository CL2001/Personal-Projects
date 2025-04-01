#lang scheme

(display '(1 2 3))
(newline)
(display (list 1 2 3))
(newline)
(display (cons '1 (cons '2 (cons '3 '()))))
(newline)

(define square-diff
  (lambda (x1 x2)
    (* (- x1 x2) (- x1 x2))))

(display (square-diff 10 4))
(newline)

(define x '(a (b c) d ((e f) g)))
(display (car (cdr (car (cdr (cdr (cdr x)))))))
(newline)
(display (cadr(cadddr x)))
(newline)

(define (my-last list)(
    if (or(null? (cdr list)) (null? list))
    (car list)
    (my-last (cdr list))
))

(display (my-last '(a b c d)))
(newline)

(define (compress liste)
  (if (or (null? liste) (null? (cdr liste)))
      liste
      (let ((compress-cdr (compress (cdr liste))))
        (if (equal? (car liste) (car compress-cdr))
            compress-cdr
            (cons (car liste) compress-cdr)))))
            
(display (compress '(a a a a b c c a a d e e e e)))
(newline)


(define (replicate-it lst count)
  (define (replicate-element element how-many)
    (if (= how-many 0)
        '()
        (cons element
              (replicate-element element (- how-many 1)))))
  (if (null? lst)
      '()
      (append (replicate-element (car lst) count)
              (replicate-it (cdr lst) count))))

(display (replicate-it '(a b c) 9))
(newline)


(display (compress(replicate-it '(a b c) 9)))
(newline)
