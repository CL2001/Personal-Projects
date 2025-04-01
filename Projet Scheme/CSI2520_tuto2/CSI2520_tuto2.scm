#lang scheme

(define (my-flatten L)
    (if (null? L) '()  
    (append (if (list? (car L)) (my-flatten (car L))
            (list (car L)))   
        (my-flatten (cdr L)))
    )
)


(display '(a (b (c d) e)))
(newline)
(display(my-flatten '(a (b (c d) e))))


(define (make-copies element num)
    (if (<= num 0)
        '()
        (cons element (make-copies element (- num 1)))
    )
)
(define (repli L num)
    (if (null? L) '()
        (append (make-copies (car L) num) (repli (cdr L) num))
    )
)

(newline)
(display(repli '(a b c) 3))



(define (range num1 num2)
    (if (> num1 num2) '()
        (cons num1 (range (+ num1 1) num2))
    )
)

(newline)
(display(range 4 9))





(define (remove-at L index)
    (if (= index 1) (cdr L)
        (cons (car L) (remove-at (cdr L) (- index 1)))
    )
)

(newline)
(display(remove-at '(a b c d) 2))



(define (insert-at mot L index)
    (if (= index 1) (cons mot L)
        (cons (car L) (insert-at mot (cdr L) (- index 1)))
    )
)

(newline)
(display(insert-at 'alfa '(a b c d) 2))


(define (rnd-select L how-many)
 (define (my-random n) (+ 1 (random n))) ; 1 <= random number <= n
 (if (= 0 how-many)
 '()
 (let ((place (my-random (length L))))
 (cons (list-ref L (- place 1)) ; list-ref is 0 indexed
 (rnd-select (remove-at L place)
 (- how-many 1))))))

(newline)
(display(rnd-select '(a b c d e f g h) 3))


(define (rnd-permu L)
 (rnd-select L
 (length L)))

(newline)
(display(rnd-permu '(a b c d e f)))
