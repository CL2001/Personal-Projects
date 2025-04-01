trajet('Windsor', 'Toronto', bus).
trajet('Windsor', 'Detroit', bus).
trajet('Toronto', 'NorthBay', bus).
trajet('Toronto', 'Montreal', bus).
trajet('Toronto', 'Ottawa', bus).
trajet('Toronto', 'Kingston', bateau).
trajet('Kingston', 'Ottawa', bateau).
trajet('Montreal', 'Ottawa', bus).

trajet_possible(X, Z) :- trajet(X, Y, _), trajet(Y, Z, _).

destination_possible(X) :- trajet(X, _, _); trajet(_, X, _).

escale(Y, X, Z) :- trajet(X, Y, _), trajet(Y, Z, _).


alternance(bus, bateau).
alternance(bateau, bus).
chemin_agreable(X, Y) :-
    trajet(X, Z, Mode),
    alternance(Mode, NextMode),
    chemin_agreable_rec(Z, Y, NextMode).

chemin_agreable_rec(X, Y, Mode) :- trajet(X, Y, Mode). %Mode de base recursif
chemin_agreable_rec(X, Y, Mode) :- 
    trajet(X, Z, Mode),
    alternance(Mode, NextMode),
    chemin_agreable_rec(Z, Y, NextMode). %Modele recursif


/*
1. y a t il un trajet entre Windsor et Ottawa?
1 ?- trajet_possible('Windsor', 'Ottawa').
true .


2. Peut-on visiter la ville du Québec?
1 ?- destination_possible('Toronto').                                                                        
true .

2 ?- destination_possible('Quebec'). 
false.


3. Quelles sont les villes escales pour aller de Toronto à Ottawa (considérer une seule
escale).
1 ?- escale(Y, 'Toronto', 'Ottawa').
Y = 'Montreal' ;
Y = 'Kingston'.


4. Peut on avoir un chemin agréable entre Windsor et Kingston? (un chemin est dit
agréable lorsqu’il alterne un trajet en bus et un trajet en bateau!).
1 ?- chemin_agreable('Windsor', 'Kingston').
true .
*/