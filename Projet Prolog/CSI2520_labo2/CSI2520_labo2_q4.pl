parent(john, mary).
parent(john, tom).
parent(mary, ann).
parent(mary, fred).
parent(tom, liz).
male(john).
male(tom).
male(fred).
female(mary).
female(ann).
female(liz).


% mother(Mother, Child): Ce prédicat devrait être vrai si Mother est la mère de Child.
mother(M, C) :- parent(M, C), female(M).
/*
1 ?- mother(mary, fred).
true.

2 ?- mother(john, mary).
false.
*/

% sibling(Sibling1, Sibling2): Ce prédicat devrait être vrai si Sibling1 est le frère ou la soeur de Sibling2.
sibling(S1, S2) :- parent(P, S1), parent(P, S2).
/*
1 ?- sibling(mary, tom).
true.

2 ?- sibling(fred, liz).
false.
*/

% grandparent(Grandparent, Grandchild): Ce prédicat devrait être vrai si Grandparent est un grand-parent de Grandchild.
grandparent(Grandparent, Grandchild) :- parent(Grandparent, P), parent(P, Grandchild).
/*
1 ?- grandparent(john, ann).
true .

2 ?- grandparent(mary, fred).
false.
*/

% ancestor(Ancestor, Descendant): Ce prédicat devrait être vrai si Ancestor est un ancêtre de Descendant.
ancestor(Ancestor, Descendant) :- parent(Ancestor, Descendant).
ancestor(Ancestor, Descendant) :- ancestor(Ancestor, P), parent(P, Descendant).

/*
1 ?- ancestor(mary, ann).
true .

2 ?- ancestor(john, liz).
true .
*/