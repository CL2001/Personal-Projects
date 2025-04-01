% family.pl - A more comprehensive Prolog script for testing family relationships

% Facts: Parent-child relationships
parent(john, mary).
parent(john, peter).
parent(mary, susan).
parent(peter, kevin).
parent(susan, alice).
parent(kevin, tom).
parent(peter, linda).

% Gender facts
male(john).
male(peter).
male(kevin).
male(tom).

female(mary).
female(susan).
female(alice).
female(linda).

% Sibling relationships: Two persons are siblings if they share at least one parent and are not the same person.
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% Grandparent relationships: X is a grandparent of Y if X is a parent of Z and Z is a parent of Y.
grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

% Ancestor relationship: X is an ancestor of Y if X is a parent of Y or if X is a parent of some Z who is an ancestor of Y.
ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

% Uncle and Aunt relationships: X is an uncle or aunt of Y if X is a sibling of one of Y's parents.
uncle_aunt(X, Y) :-
    parent(P, Y),
    sibling(X, P).

% Cousin relationship: Two persons are cousins if their parents are siblings.
cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2).

% Additional sample queries (run these after loading the file):
%
% 1. Are Mary and Peter siblings?
%    ?- sibling(mary, peter).
%
% 2. Is John the grandparent of Susan?
%    ?- grandparent(john, susan).
%
% 3. Is John an ancestor of Tom?
%    ?- ancestor(john, tom).
%
% 4. Is Mary an aunt of Kevin? (Mary is sibling to Peter, who is Kevin's parent.)
%    ?- uncle_aunt(mary, kevin).
%
% 5. Are Alice and Tom cousins?
%    ?- cousin(alice, tom).
%
% 6. Who are the ancestors of Linda?
%    ?- ancestor(X, linda).
