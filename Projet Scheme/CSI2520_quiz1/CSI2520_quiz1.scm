#lang scheme
(define (sqstep n)
    (if (<= n 0)
        0
    (if(<= n 1)
        (* n n)
        1
)))


(display (sqstep -9))
(newline)
(display (sqstep 0.1))
(newline)
(display (sqstep 0.7))
(newline)
(display (sqstep 0.99))
(newline)
(display (sqstep 2))
(newline)
