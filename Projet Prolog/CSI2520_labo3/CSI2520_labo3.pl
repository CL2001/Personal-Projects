%Q1
decompte(N) :- 
    N >= 0, 
    writeln(N), 
    N1 is N - 1, 
    decompte(N1).
%decompte(5).

%Q2
element(chlore,'Cl').
element(helium,'He').
element(hydrogene,'H').
element(azote,'N').
element(oxygene,'O').
donne_element :-
    repeat,
    write('Donnez-moi un symbole : '),
    read(Symbol),
    (   element(Element, Symbol)
    ->  format('~w est le symbole de : ~w~n', [Symbol, Element]),
        fail
    ;   writeln('Je l\'ignore. Au revoir.'),
        !, halt
    ).

%Q3
canalOuvert(samedi).
canalOuvert(lundi).
canalOuvert(mardi).
pleuvoir(samedi).
fond(samedi).
fond(dimanche).
fond(lundi).
balDeNeige(X) :- canalOuvert(X), not(pleuvoir(X)), not(fond(X)).

%Q4
avantDernier(X, [X, _]).
avantDernier(X, [_|Tail]) :- avantDernier(X, Tail).

