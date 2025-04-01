combat(paul, pierre).
combat(jean, simon).
combat(jean, pierre).

allies(X,Y) :- combat(X, Z), combat(Y, Z).


/*
1 ?- allies(X,Y).
X = Y, Y = paul ;
X = paul,
Y = jean ;
X = Y, Y = jean ;
X = jean,
Y = paul ;
X = Y, Y = jean.
*/