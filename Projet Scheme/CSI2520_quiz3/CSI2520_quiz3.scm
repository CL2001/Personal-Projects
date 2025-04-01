#lang scheme



(define (absDiffb L1 L2)
  (cond ((null? L1) L2)
        ((null? L2) L1)
        (else (cons (abs (- (car L1) (car L2))) (absDiffb (cdr L1) (cdr L2))))
  )
)


(absDiffb '(1 3 5 6 2 5) '(3 5 2 1))
;(2 2 3 5 2 5) 

(absDiffb '(1 3 5 6) '(3 5 2 1 2 5))
;(2 2 3 5 2 5)