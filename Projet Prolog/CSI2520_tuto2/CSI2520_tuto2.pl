% Q1
temp_cf(F, C) :- F is C * 9 / 5 + 32.
freezing(T) :- T =< 32. %IMPORTANT CEST =< PAS >=.......

% Q2
heureSuivanteS(c(H, M, S), c(H, M, SN)) :- S < 59, SN is S+1.
heureSuivanteS(c(H, M, S), c(H, MN, 0)) :- S =:= 59, M < 59, MN is M+1.
heureSuivanteS(c(H, M, S), c(HN, 0, 0)) :- S =:= 59, M =:= 59, H < 23, HN is H + 1.
heureSuivanteS(c(H, M, S), c(0, 0, 0)) :- S =:= 59, M =:= 59, H =:=23.


% Q3
factorial(0,1).
factorial(N,F) :-
 N>0,
 N1 is N-1,
 factorial(N1,F1),
 F is N * F1.

% Q4
regne(philippeIV,1285,1314).
regne(philippeIII,1270,1285).
est_roi_en(Nom,Annee):- regne(Nom,A,B), Annee>=A, Annee=<B.

% 1 ?- est_roi_en(N, 1275).
% N = philippeIII.


% Q5
% joueur(Joueur, Nom, Equipe)
joueur(p1, 'Stan', t1).
joueur(p2, 'Pierre', t1).
joueur(p3, 'Jochen', t2).
joueur(p4, 'Robert', t2).
joueur(p5, 'Paul', t3).
joueur(p6, 'Samuel', t3).
% match (Match, EquipeLocale, EquipeVisiteuse, Saison).
match(g1, t1, t2, hiver11).
match(g2, t2, t3, hiver11).
match(g3, t1, t3, automne12).
match(g4, t2, t3, automne12).
match(g4, t2, t1, automne12).
% but(Match, Joueur, TempsDuButEnMinutes)
but(g1, p1, 55). but(g1, p2, 10).
but(g1, p1, 22). but(g2, p3, 37).
but(g2, p3, 41). but(g2, p6, 60).
but(g3, p2, 33). but(g3, p5, 49). 


but_demi_moitie_h11(Equipe) :- match(G, Equipe, _, hiver11), joueur(P, _, Equipe), but(G, P, Time), Time > 45.

marqueur(Joueur) :- but(_, Joueur, _).

marqueur2(Joueur) :- but(G1, Joueur, _), but(G2, Joueur, _), G1 \= G2.

no_homeA12(Equipe) :- joueur(_, _, Equipe), \+ match(_, Equipe, _, automne12).



% Q6
ack(0, Y, A) :- A is Y + 1.
ack(X, 0, A) :- NX is X - 1, ack(NX, 1, A).
ack(X, Y, A) :- NX is X - 1, NY is Y - 1, ack(X, NY, A1), ack(NX, A1, A).

% Q7
suspect(X) :- present(X, L, J), vol(L, J, V), apuvoler(X, V).
apuvoler(X, _) :- sansargent(X).
apuvoler(X, Y) :- jaloux(X, Y).
vol(hipp, lundi, marie).
vol(bar, mardi, jean).
vol(stade, jeudi, luc).
sansargent(max).
jaloux(eve, marie).
present(max, bar, mercredi).
present(eric, bar, mardi).
present(eve, hipp, lundi).
