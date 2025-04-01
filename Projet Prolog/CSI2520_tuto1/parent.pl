parent(jack,joe).
parent(jack,karl).
parent(marie,anne).
parent(joe,anne).
parent(marie,paul).
parent(joe,paul).
parent(marie,sylvie).
parent(bruno,sylvie).
parent(anne,zach).
parent(tim,zach).
parent(sam,tim).
parent(emma,tim).
parent(josee,sam).
parent(gilles,sam).
femme(marie).
femme(sylvie).
femme(anne).
femme(emma).
femme(josee).
homme(karl).
homme(jack).
homme(joe).
homme(bruno).
homme(paul).
homme(tim).
homme(zach).
homme(sam).
homme(gilles).

soeur(X, Y) :- parent(Z, X), parent(Z, Y), femme(X).

/*
1 ?- soeur(X,paul). 
X = anne ;
X = anne ;
X = sylvie ;
false.
*/