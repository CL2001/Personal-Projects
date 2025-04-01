numero_input(Y) :-
    write('Give me a number: '),
    read(X),
    calcul(X, Y).


calcul(1, 2).
calcul(X, Y) :- 
    X > 0,
    X1 is X-1,
    calcul(X1, Y1),
    Y is 2 * Y1.


