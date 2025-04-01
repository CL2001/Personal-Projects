p(a,b).
p(a,c).
p(c,d).
p(d,e).
p(d,f).
p(n,w).

q(A,B) :- p(A,B).
q(A,B) :- p(X,B), q(A,X).

/*
1 ?- q(a, e).
true ;
false.
*/