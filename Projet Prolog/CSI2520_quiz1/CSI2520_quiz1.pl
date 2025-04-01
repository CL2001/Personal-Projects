% Fait

% Relation genre
homme(jean).
femme(marie).

% Relation parent
parent(marie, jean).

% Relation mere si X est parent de Y et X est une femme
mere(X,Y) :- parent(X,Y), femme(X).

% Demande si marie est la mère à jean
% ?- mere(marie, jean).