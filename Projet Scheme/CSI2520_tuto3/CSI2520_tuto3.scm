#lang scheme

(define (transpose list-of-pairs)
  (let ((firsts (map car list-of-pairs)) 
        (seconds (map cdr list-of-pairs)))
    (cons firsts seconds)))


(display(transpose '((a . 1) (b . 2) (c . 3))) )
(newline)




(define (make-list num L)
    (if (<= num 0) '()
        (cons L (make-list (- num 1) L))
    )
    
)

(display(make-list 7 '(a b)))
(newline)



(define (shorter list1 list2)
  (if (null? list1)
      list1
      (if (null? list2)
        list2
          (let ((shorter-tail (shorter (cdr list1) (cdr list2))))
            (if (eq? shorter-tail (cdr list1))
                list1
                list2)))))
(display(shorter '(a b c d) '(f g h)))
(newline)



(define (take n lst)
  (if (or (<= n 0) (null? lst))
      '()
      (cons (car lst) (take (- n 1) (cdr lst)))))


(define (drop n lst)
  (if (or (<= n 0) (null? lst))
      lst
      (drop (- n 1) (cdr lst))))

(define (split lst)
  (let* ((len (length lst))
         (midpoint (quotient len 2))
         (first-half (take midpoint lst))
         (second-half (drop midpoint lst)))
    (list first-half second-half)))



(display(split '(a b c d e)))
(newline)


(define (mergelists list1 list2)
  (cond
    ((null? list1) list2)
    ((null? list2) list1)
    (else
     (let ((head1 (car list1))
           (head2 (car list2)))
       (if (<= head1 head2)
           (cons head1 (mergelists (cdr list1) list2))
           (cons head2 (mergelists list1 (cdr list2))))))))

(display(mergelists '(1 3 4 7) '(2 5 6 8)))
(newline)