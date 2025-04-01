% Projet de Christophe Lanouette 300171137
% Fichier : projectMovie.pl
:- use_module(library(csv)).
:- dynamic user/3, movie/2.

% Définition des constantes :
% min_liked(K) : Nombre minimal d'utilisateurs ayant aimé un film pour qu'il soit considéré.
min_liked(10).

% liked_th(R) : Seuil de notation pour considérer qu'un film est "aimé".
liked_th(3.5).

% number_of_rec(N) : Nombre de recommandations à afficher.
number_of_rec(20).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lecture des utilisateurs depuis le fichier CSV et assertion des faits utilisateur.
%
% read_users(+Filename)
%   Lit le fichier CSV contenant les évaluations des utilisateurs et appelle assert_users/1 pour
%   créer une base de faits utilisateurs.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
read_users(Filename) :-
    csv_read_file(Filename, Data),
    assert_users(Data).

% Prédicat auxiliaire pour asserter les faits utilisateurs à partir des données CSV.
assert_users([]).
assert_users([row(U,_,_,_) | Rows]) :-
    \+ number(U), !,  % Ignorer les lignes où U n'est pas un nombre.
    assert_users(Rows).
assert_users([row(U,M,Rating,_) | Rows]) :-
    number(U),
    \+ user(U,_,_), 
    liked_th(R),
    Rating >= R, !,
    assert(user(U, [M], [])),
    assert_users(Rows).
assert_users([row(U,M,Rating,_) | Rows]) :-
    number(U),
    \+ user(U,_,_),
    liked_th(R),
    Rating < R, !,
    assert(user(U, [], [M])),
    assert_users(Rows).
assert_users([row(U,M,Rating,_) | Rows]) :-
    number(U),
    liked_th(R),
    Rating >= R, !,
    retract(user(U, Liked, NotLiked)),
    assert(user(U, [M|Liked], NotLiked)),
    assert_users(Rows).
assert_users([row(U,M,Rating,_) | Rows]) :-
    number(U),
    liked_th(R),
    Rating < R, !,
    retract(user(U, Liked, NotLiked)),
    assert(user(U, Liked, [M|NotLiked])),
    assert_users(Rows).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lecture des films depuis le fichier CSV et assertion des faits film.
%
% read_movies(+Filename)
%   Lit le fichier CSV contenant les films et appelle assert_movies/1 pour
%   créer une base de faits films.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
read_movies(Filename) :-
    csv_read_file(Filename, Rows),
    assert_movies(Rows).

assert_movies([]).
assert_movies([row(M,_,_) | Rows]) :-
    \+ number(M), !,
    assert_movies(Rows).
assert_movies([row(M,Title,_) | Rows]) :-
    number(M), !,
    assert(movie(M, Title)),
    assert_movies(Rows).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Affichage des N premiers éléments d'une liste.
%
% display_first_n(+List, +N)
%   Affiche les N premiers éléments de List. Si N est zéro ou si la liste est vide,
%   le prédicat réussit sans afficher d'autres éléments.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display_first_n(_, 0) :- !.
display_first_n([], _) :- !.
display_first_n([H|T], N) :-
    writeln(H),
    N1 is N - 1,
    display_first_n(T, N1).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% similarity(+User1, +User2, -Sim)
%    - Calcule la similarité entre deux utilisateurs en utilisant l'indice de Jaccard.
%    - La similarité est définie par :
%         S(U1, U2) = (|L(U1) ∩ L(U2)| + |D(U1) ∩ D(U2)|) /
%                     |L(U1) ∪ L(U2) ∪ D(U1) ∪ D(U2)|
%      où L(User) est la liste des films aimés et D(User) la liste des films non aimés.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
similarity(U1, U2, Score) :- 
    user(U1, U1Liked, U1Disliked),
    user(U2, U2Liked, U2Disliked),
    intersection(U1Liked, U2Liked, LikedIntersection),
    intersection(U1Disliked, U2Disliked, DislikedIntersection),
    union(U1Liked, U2Liked, LikedUnion),
    union(U1Disliked, U2Disliked, DislikedUnion),
    union(LikedUnion, DislikedUnion, TotalUnion),
    length(LikedIntersection, LikedIntersectionLength),
    length(DislikedIntersection, DislikedIntersectionLength),
    length(TotalUnion, TotalUnionLenght),
    ( TotalUnionLenght =:= 0 ->
          Score = 0
    ;     Score is (LikedIntersectionLength + DislikedIntersectionLength) / TotalUnionLenght
    ).
    
     


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prob(+User, +Movie, -Prob)
%    - Calcule la probabilité que l'utilisateur User aime le film Movie.
%    - Si le film n'a pas été vu (aimé) par au moins min_liked utilisateurs, alors Prob doit être 0.0.
%    - Sinon, pour chaque utilisateur V (≠ User) ayant aimé le film, calcule la similarité S(User,V)
%      et cumule ces similarités pour obtenir un score. Finalement, Prob est égal au score divisé
%      par le nombre d'utilisateurs ayant aimé le film.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prob(User, Movie, Prob) :-
    setof(U, L^D^(user(U, L, D)), AllUsers),
    liked(Movie, AllUsers, UsersWhoLiked),
    prob_recurs(User, Movie, 0, 0, UsersWhoLiked, Prob).

prob_recurs(_, _, _Score, NAime, [], 0) :-
    NAime < 10.

prob_recurs(_, _, Score, NAime, [], Prob) :-
    NAime >= 10,
    Prob is Score / NAime.

prob_recurs(User, Movie, Score, NAime, [CompUserID|Reste], Prob) :-
    User = CompUserID,
    prob_recurs(User, Movie, Score, NAime, Reste, Prob).

prob_recurs(User, Movie, Score, NAime, [CompUserID|Reste], Prob) :-
    User \= CompUserID,
    user(CompUserID, Liked, _),
    member(Movie, Liked),
    similarity(User, CompUserID, Similarity_Score),
    Score1 is Score + Similarity_Score,
    NAime1 is NAime + 1,
    prob_recurs(User, Movie, Score1, NAime1, Reste, Prob).
    



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% liked(+Movie, +Users, -UserWhoLiked)
%    - Filtre la liste Users pour ne retourner que ceux qui ont le film Movie dans leur liste d'aimés.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
liked(Movie, Users, UsersWhoLiked) :-
    findall(User,
        (member(User, Users),
         user(User, Liked, _),
         member(Movie, Liked)
        ),
    UsersWhoLiked).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% seen(+User, +Movie)
%    - Vérifie si l'utilisateur User a vu le film Movie.
%    - Un utilisateur est considéré comme ayant vu un film s'il apparaît dans sa liste d'aimés ou non aimés.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
seen(User, Movie) :-
    user(User, Liked, Disliked),
    (member(Movie, Liked); member(Movie, Disliked)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prob_movies(+User, +Movies, -Recs)
%    - Pour un utilisateur donné et une liste d'IDs de films, calcule une liste de paires (MovieTitle, Prob),
%      où Prob est la probabilité que l'utilisateur aime le film (en utilisant prob/3).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prob_movies(_, [], []).
prob_movies(User, [CurrentMovie|RestMovies], Rec) :-
    seen(User, CurrentMovie), !,
    prob_movies(User, RestMovies, Rec).
prob_movies(User, [CurrentMovie|RestMovies], [(Title, Score)|RestRecs]) :-
    \+ seen(User, CurrentMovie),
    movie(CurrentMovie, Title),
    prob(User, CurrentMovie, Score),
    prob_movies(User, RestMovies, RestRecs).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% recommendations(+User)
%    - Prédicat principal qui génère les recommandations de films pour un utilisateur donné.
%    - Il doit :
%         a. Générer une liste de tous les IDs de films.
%         b. Calculer la probabilité pour chaque film en utilisant prob_movies/3.
%         c. Trier les recommandations par ordre décroissant de probabilité.
%         d. Afficher les top number_of_rec recommandations en utilisant display_first_n/2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recommendations(User) :-
    setof(M, L^movie(M, L), Ms),        % Générer la liste de tous les IDs de films
    prob_movies(User, Ms, Rec),          % Calculer les probabilités pour tous les films
    sort(2, @>=, Rec, Rec_Sorted),       % Trier les recommandations par probabilité décroissante
    number_of_rec(N),
    display_first_n(Rec_Sorted, N).      % Afficher le résultat




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prédicats d'initialisation et de test.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%   Charge les données des utilisateurs et des films depuis les fichiers CSV.
init :-
    read_users('ratings.csv'),
    read_movies('movies.csv').
:- initialization(init).


% Prédicats de test pour vérifier l'implémentation.
test(1) :-
    similarity(33, 88, S1),
    291 is truncate(S1 * 10000),
    similarity(44, 55, S2),
    138 is truncate(S2 * 10000).

test(2) :-
    prob(44, 1080, P1),
    122 is truncate(P1 * 10000),
    prob(44, 1050, P2),
    0 is truncate(P2).

test(3) :-
    liked(1080, [28, 30, 32, 40, 45, 48, 49, 50], [28, 45, 50]).

test(4) :-
    seen(32, 1080),
    \+ seen(44, 1080).

test(5) :-
    prob_movies(44, [1010, 1050, 1080, 2000], Rs),
    length(Rs, 4),
    display(Rs).


