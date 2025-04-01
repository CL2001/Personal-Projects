; Devoir Scheme de Christophe Lanouette 300171137
#lang scheme

; Q1
(define (sort-length L)
    (sort L 
        (lambda (LA LB) (< (length LA) (length LB)))
    )
)
; Utilise la fonction prédéfini sort avec une fonction lambda pour décrire comment la trié
(display(sort-length '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o))))
(newline)



;Q2
(define (modulo num1 num2)
  (- num1 (* num2 (floor (/ num1 num2))))
)
(define (gcd num1 num2)
    (if (= num2 0) num1
    (gcd num2 (modulo num1 num2))
    )
)
(define (coprime? num1 num2)
    (= 1 (gcd num1 num2))
)
; Utilise l'algorithme récursif pour trouvé le plus gcd. Une fois trouvé, si celui ci est 1
; les numéros sont coprime
(display(coprime? 35 64))
(newline)
(display(coprime? 16 64))
(newline)



;Q3
; Traverse l'arbre et vérifie si on est à une feuille avec cadr et caddr qui vaut '()
; Si c'est le cas, la valeur est ajouté à la liste avec la fonction list
(define tree '(5 (3 (1 () ()) (4 () ()))
 (8 (7 () ()) (10 () ()))))

(define leaves (lambda (T)
    (if (null? T) '()
        (if (and (null? (cadr T)) (null? (caddr T))) (list (car T))
            (append (leaves (cadr T)) (leaves (caddr T)))
        )
    ) 
  ) 
)

(display(leaves tree))
