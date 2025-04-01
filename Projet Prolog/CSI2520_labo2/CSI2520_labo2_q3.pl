%Appel la version recursive
factoriel(N, R) :- factoriel(N, 1, 1, R).
% Cas de base et retourne le résultata en R
factoriel(N, I, Acc, Acc) :- I > N.

% Appel récursif
factoriel(N, I, Acc, R) :-
    N >= I,
    Acc1 is Acc * I,
    I1 is I + 1,
    factoriel(N, I1, Acc1, R).



% Combinaison(N, K) = N! / (K! * (N-K)!)
combinaison(K, N, R) :- factoriel(N, RN), factoriel(K, RK), factoriel(N-K, RNK), R is RN / (RK * RNK).
/*
1 ?- combinaison(6, 49, R).
R = 13983816 .
*/