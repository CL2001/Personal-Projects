; Projet de Christophe Lanouette 300171137
; Avancé dans la dir du code avant de run, sinon le fichier .csv n'est pas importé
#lang scheme

; lecture de csv
(define (read-f filename) (call-with-input-file filename
      (lambda (input-port)
       (let loop ((line (read-line input-port)))
       (cond 
        ((eof-object? line) '())
        (#t (begin (cons (string-split line ",") (loop (read-line input-port))))))))))

; conversion du csv en liked/notLiked
(define (convert-rating L) (list (string->number (car L)) (string->number (cadr L)) (< 3.5 (string->number (caddr L)))))

; Permet de définir la liste Ratings
;(define Ratings (map convert-rating (read-f "test.csv")))
(define Ratings (map convert-rating (read-f "ratings.csv")))





;-------------------------------------------------------------------------------
; Fonction: add-rating
; Description: Ajoute une seule notation (rating) à une liste existante de
;              profils utilisateurs (list-of-users). Si l'utilisateur existe
;              déjà, sa liste d'items aimés ou non aimés est mise à jour.
;              Si l'utilisateur n'existe pas, un nouveau profil est créé et
;              ajouté à la liste.
; Paramètres:
;   - rating: Une liste représentant une notation unique au format
;             (user-id item-id liked?). Ex: (31 316 #f)
;   - list-of-users: La liste actuelle des profils utilisateurs, où chaque
;                    profil est au format (user-id (liked...) (disliked...)).
;                    Ex: ((1 (333) ()) (31 () ()))
; Retourne: La nouvelle liste de profils utilisateurs mise à jour avec la
;           notation ajoutée.
;-------------------------------------------------------------------------------
(define (add-rating rating list-of-users)
    (cond
        ; Si la liste est null on ajoute un utilisateur
        ((null? list-of-users)
            (let (
                  (user-id (car rating))
                  (item-id (cadr rating))
                  (liked? (caddr rating))
                  )
                  (list (list user-id (if liked? (list item-id) '()) (if liked? '() (list item-id))))
            )
        )

        ; Si l'utilisateur n'est pas celui rechercher, on traverse la liste des utilisateurs pour le prochain
        ((not (equal? (car rating) (caar list-of-users)))
            (cons (car list-of-users) (add-rating rating (cdr list-of-users)))
        )

        ; Si l'utilisateur est celui recherché, on ajoute notre film dans sa liste
        (else
            (let* ((user-entry (car list-of-users))
                    (rest-users (cdr list-of-users))
                    (user-id (car user-entry))
                    (item-id (cadr rating))
                    (liked? (caddr rating))
                    (liked-list (cadr user-entry))
                    (disliked-list (caddr user-entry)))
            (if liked? (cons (list user-id (cons item-id liked-list) disliked-list) rest-users)
                (cons (list user-id liked-list (cons item-id disliked-list)) rest-users))
            )
        )
    )
)

; Test add-rating
;(display(add-rating '(31 316 #f) (add-rating '(31 333 #t) '())))
;(newline)
;((31 (333) (316)))
;(display(add-rating '(31 362 #t) (add-rating '(31 316 #f) (add-rating '(31 333 #t) '()))))
;(newline)
;((31 (362 333) (316)))
;(display(add-rating '(31 362 #t) (add-rating '(31 316 #f) (add-rating '(1 333 #t) '()))))
;(newline)
;((31 (362) (316)) (1 (333) ()))






;-------------------------------------------------------------------------------
; Fonction: add-ratings
; Description: Prend une liste de notations brutes et construit la structure
;              complète des profils utilisateurs en appelant récursivement
;              'add-rating' pour chaque notation.
; Paramètres:
;   - list-of-ratings: Une liste de notations, chacune au format
;                      (user-id item-id liked?). Ex: ((3 44 #f) (3 55 #f)...)
;   - list-of-users: L'état initial de la liste des profils utilisateurs
;                    (typiquement '() pour commencer).
; Retourne: La liste complète des profils utilisateurs après traitement de
;           toutes les notations. Ex: ((3 (11 66) (55 44)) (7 (88) (44)))
;-------------------------------------------------------------------------------
(define (add-ratings list-of-ratings list-of-users)
      (if (null? list-of-ratings) '()
            (add-rating (car list-of-ratings) (add-ratings (cdr list-of-ratings) list-of-users))
      )
)

; Test add-ratings
;(add-ratings '((3 44 #f) (3 55 #f) (3 66 #t) (7 44 #f) (3 11 #t) (7 88 #t)) '())
;((3 (11 66) (55 44)) (7 (88) (44)))
;(add-ratings Ratings '())
;((1 (260 235 231 216 163 157 151 110 101 50 47 6 3 1) (223 70)) (31 (367 362 356 349 333 260 235 231) (316 296 223)))





;-------------------------------------------------------------------------------
; Fonction: get-user
; Description: Recherche et retourne le profil complet d'un utilisateur spécifique
;              à partir de son ID dans la liste des profils utilisateurs.
; Paramètres:
;   - ID: L'identifiant numérique de l'utilisateur à rechercher.
;   - ratings: La liste complète des profils utilisateurs, où chaque profil est
;              au format (user-id (liked...) (disliked...)).
; Retourne: Le profil de l'utilisateur trouvé (une liste au format
;           (user-id (liked...) (disliked...))) ou '() si l'utilisateur
;           n'est pas trouvé dans la liste.
;-------------------------------------------------------------------------------
(define (get-user ID ratings)
      (cond
            ((null? ratings) '())
            ((equal? ID (caar ratings)) (car ratings))
            (else (get-user ID (cdr ratings)))
      )
)
; Test get-user
;(get-user 31 (add-ratings Ratings '()))
;(31 (367 362 356 349 333 260 235 231) (316 296 223))



;-------------------------------------------------------------------------------
; Fonction: intersect-list
; Description: Calcule l'intersection de deux listes L1 et L2. Retourne une
;              nouvelle liste contenant les éléments de L1 qui sont également
;              présents dans L2 (vérifié avec `member`).
;              Préserve les doublons de L1 s'ils existent dans L2.
; Paramètres:
;   - L1: La première liste.
;   - L2: La deuxième liste.
; Retourne: Une liste contenant les éléments communs, dans l'ordre où ils
;           apparaissent dans L1.
;-------------------------------------------------------------------------------
(define (intersect-list L1 L2)
      (cond 
            ((null? L1) '())
            ((member (car L1) L2) (cons (car L1) (intersect-list (cdr L1) L2)))
            (else (intersect-list (cdr L1) L2))
      )
)

;-------------------------------------------------------------------------------
; Fonction: remove-dups et union-list
; Description: Calcule l'union de deux listes L1 et L2. Retourne une nouvelle
;              liste contenant tous les éléments présents dans L1 ou L2, sans
;              doublons. L'implémentation concatène les listes puis supprime
;              les doublons.
; Paramètres:
;   - L1: La première liste.
;   - L2: La deuxième liste.
; Retourne: Une liste contenant l'union des éléments de L1 et L2, sans doublons.
;-------------------------------------------------------------------------------
(define (remove-dups L)
      (cond 
            ((null? L) '())
            ((member (car L) (cdr L)) (remove-dups (cdr L)))
            (else (cons (car L) (remove-dups (cdr L))))
      )
)
(define (union-list L1 L2)
      (remove-dups (append L1 L2))
)


;-------------------------------------------------------------------------------
; Fonction: get-similarity
; Description: Calcule un score de similarité entre deux utilisateurs (U1 et U2)
;              basé sur l'indice de Jaccard appliqué à leurs items aimés et non
;              aimés. La formule est :
;              ( |Liked1 ∩ Liked2| + |Disliked1 ∩ Disliked2| ) / |Rated1 ∪ Rated2|
;              où Rated = Liked ∪ Disliked.
;              La fonction reconstruit la base de données des profils à chaque appel.
; Paramètres:
;   - U1: L'ID numérique du premier utilisateur.
;   - U2: L'ID numérique du deuxième utilisateur.
; Retourne: Un nombre exact (entier ou rationnel) représentant le score de
;           similarité Jaccard entre U1 et U2.
;-------------------------------------------------------------------------------
(define (get-similarity U1 U2)
  (let* (
        (user-profiles (add-ratings Ratings '()))
        (u1-profile (get-user U1 user-profiles))
        (u2-profile (get-user U2 user-profiles))
        (u1-liked (cadr u1-profile))
        (u2-liked (cadr u2-profile))
        (u1-disliked (caddr u1-profile))
        (u2-disliked (caddr u2-profile))
        (liked-intersect (intersect-list u1-liked u2-liked))
        (disliked-intersect (intersect-list u1-disliked u2-disliked))
        (liked-union (union-list u1-liked u2-liked))
        (disliked-union (union-list u1-disliked u2-disliked))
        (full-union (union-list liked-union disliked-union))
        )
        (/ (+ (length liked-intersect) (length disliked-intersect)) (length full-union))
  )
)



; test similarity
;(get-similarity 1 31)
;(get-similarity 33 88) ;3/103
(exact->inexact(get-similarity 33 88)) ;0.02912621359223301




