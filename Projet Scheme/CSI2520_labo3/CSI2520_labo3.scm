#lang scheme

(define (arbre-insere arbre valeur)
  (cond ((null? arbre) (list valeur '() '()))
        ((< valeur (car arbre))
         (list (car arbre)
               (arbre-insere (cadr arbre) valeur)
               (caddr arbre)))
        (else
         (list (car arbre)
               (cadr arbre)
               (arbre-insere (caddr arbre) valeur)))))

(define (list->bst-helper lst current-bst)
  (if (null? lst)
      current-bst
      (list->bst-helper (cdr lst)
                        (arbre-insere current-bst (car lst)))))

(define (list->bst lst)
  (list->bst-helper lst '()))

(display (list->bst '(5 3 8 1 4 7 10)))
(newline)


(define (bst-height tree)
  (if (null? tree) -1
      (+ 1
         (max (bst-height (cadr tree))
              (bst-height (caddr tree))))
      )
  )


  (define (node-height tree valeur)
  (cond
    ((null? tree) -1) ; Base case: Reached an empty spot, node not found

    ((= valeur (car tree)) ; Found the node!
     (bst-height tree))    ; Calculate the height of the subtree rooted here

    ((< valeur (car tree)) ; Value is smaller, search in the left subtree
     (node-height (cadr tree) valeur))

    (else ; Value is larger, search in the right subtree
     (node-height (caddr tree) valeur))
  )
)

(define tree '(5 (3 (1 () ()) (4 () ()))
 (8 (7 () ()) (10 () ()))))
(display(bst-height tree))
(newline)

(node-height tree 5) ;; Output: 2
(node-height tree 3) ;; Output: 1
(node-height tree 1) ;; Output: 0
(node-height tree 10) ;; Output: 0
(node-height tree 99) ;; -1 (node not found)