p(a). /* #1 */
p(X) :- q(X), r(X). /* #2 */
p(X) :- u(X). /* #3 */
q(X) :- s(X). /* #4 */
r(a). /* #5 */
r(b). /* #6 */
s(a). /* #7 */
s(b). /* #8 */
s(c). /* #9 */
u(d). /* #10 */
% 1. Tracer l'arbre de recherche de P(X)
% 2. Tester les requêtes suivantes:
% ?- p(X),!.
% ?- r(X),!,s(Y).
% ?- r(X), s(Y), !. 

/*
1 ?- p(X).         
X = a ;
X = a ;
X = b ;
X = d.

2 ?- p(X),!.    
X = a.

3 ?- r(X),!,s(Y).
X = Y, Y = a ;
X = a,
Y = b ;
X = a,
Y = c.

4 ?- r(X), s(Y), !.
X = Y, Y = a.
*/

part(a). part(b). part(c).
red(a). black(b).
color(P,red) :- red(P),!.
color(P,black) :- black(P),!.
color(P,unknown).

/*
1 ?- color(a, C).
C = red.

2 ?- color(c, C).
C = unknown.
*/


s(X,Y):- q(X,Y).
s(0,0).
q(X,Y):- i(X), j(Y).
s2(X,Y):- q2(X,Y).
s2(0,0).
q2(X,Y):- i(X), !, j(Y).
i(1).
i(2).
j(1).
j(2).
j(3).

/*
1 ?- s(X, Y).
X = Y, Y = 1 ;
X = 1,
Y = 2 ;
X = 1,
Y = 3 ;
X = 2,
Y = 1 ;
X = Y, Y = 2 ;
X = 2,
Y = 3 ;
X = Y, Y = 0.

2 ?- s2(X,Y). 
X = Y, Y = 1 ;
X = 1,
Y = 2 ;
X = 1,
Y = 3 ;
X = Y, Y = 0.
*/


p(a).
p(b).
q(c).

/*
1 ?- not(p(X)), q(X).
false.

2 ?- q(X), not(p(X)).
X = c ;
X = c.
*/

sad(X) :- \+ happy(X).
happy(X) :- beautiful(X), rich(X).
rich(bill).
beautiful(michael).
rich(michael).
beautiful(cinderella).

/*
1 ?- sad(bill).
true.

2 ?- sad(cinderella).
true.

3 ?- sad(michael).
false.

4 ?- sad(jim).
true.

5 ?- sad(Someone).
false.
*/

ours(yogi).
chat(tom).
animal(yogi).
animal(tom).
aime(colbert, X) :- ours(X), !, fail.
aime(colbert, X) :- animal(X).

/*
1 ?- aime(colbert, yogi).
false.

2 ?- aime(colbert, tom).
true.

3 ?- aime(colbert, X).
false.
*/


entier(0).
entier(X):- entier(Y), X is Y+1.
boucle(N) :- repeat, entier(X), writeln(X), X>=N, !.

/*
1 ?- boucle(10).
0
1
2
3
4
5
6
7
8
9
10
true.
*/

q(a).
q(b).
s(a).
s(e).
s(f).
s(g).
k(e).
k(f).
u(e).
u(g).

p(X,X,c):-q(X), !.
p(X,Y,Z):-r(X,Y,Z),s(Z).
r(X,Y,Z):-t(X,Z), u(Y).
t(X,Z):-k(X),k(Z).

/*
1 ?- p(X,Y,Z).
X = Y, Y = a,
Z = c.
*/



