#lang scheme

(define (zeroNegative L)
  (cond
    ((null? L) L)
    ((< (car L) 0) (cons 0 (zeroNegative (cdr L))))
    (else (cons (car L) (zeroNegative (cdr L))))))



(display (zeroNegative '(-4 9 3 -2 -1 8 -6 9)))