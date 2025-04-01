% Run: swipl -s test.pl
% e. then e to stop

% Facts: Define some family relationships.
parent(alice, bob).
parent(bob, charlie).

% Rule: X is a grandparent of Y if X is a parent of Z and Z is a parent of Y.
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% To test, load this file in your Prolog interpreter and run:
% ?- grandparent(alice, charlie).