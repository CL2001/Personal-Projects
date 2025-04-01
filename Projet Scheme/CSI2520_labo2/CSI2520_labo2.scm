#lang scheme

(define (sum-pos-neg-recurs L sumpos sumneg)
    (cond
        ((null? L) (list sumpos sumneg))
        ((>= (car L) 0) (sum-pos-neg-recurs (cdr L) (+ sumpos (car L)) sumneg))
        ((< (car L) 0) (sum-pos-neg-recurs (cdr L) sumpos (+ sumneg (car L))))
    )
)

(define (sum-pos-neg L)
    (if (null? L) (list 0 0)
        (sum-pos-neg-recurs L 0 0)
    )
    
)

(display(sum-pos-neg '(2 3 -4 5 -1 1 -6 3)))
(newline)
(display(sum-pos-neg '()))
(newline)



(define (min-list x)
    (if (null? x) x
        (min-list-aux (car x)(cdr x))
    )
)
(define (min-list-aux e l)
    (cond
        ((null? l) e) ((> e (car l))
        (min-list-aux (car l)(cdr l)))
        (else (min-list-aux e (cdr l)))
    )
)


(define (min-list2 L)
    (if (null? L) L
        (let loop ((current-min (car L)) (remaining-list(cdr L)))
            (cond 
                ((null? remaining-list) current-min)
                ((> current-min (car remaining-list)) (loop (car remaining-list) (cdr remaining-list)))
                (else (loop current-min (cdr remaining-list)))
            )
        )
    )
)

(display(min-list '(4 8 9 2 8)))
(newline)
(display(min-list2 '(4 8 9 2 8)))
(newline)




(define (absDiff L1 L2)
    (cond
        ((and (null? L1) (null? L2)) '())
        ((null? L1) (cons (abs (car L2)) (absDiff '() (cdr L2))))
        ((null? L2) (cons (abs (car L1)) (absDiff (cdr L1) '())))
        (else
            (cons (abs (- (car L1) (car L2))) (absDiff (cdr L1) (cdr L2)))
        )
    )
)

(display(absDiff '(1 3 5 6) '(3 5 2 1)))
;(2 2 3 5)
(display(absDiff '(1 3 5 6 2 5) '(3 5 2 1)))
;(2 2 3 5 2 5)
(display(absDiff '(1 3 5 6) '(3 5 2 1 2 5)))
;(2 2 3 5 2 5)