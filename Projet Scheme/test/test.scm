#lang scheme

(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

; Comment with ;
(display (factorial 100)) 
(newline)
