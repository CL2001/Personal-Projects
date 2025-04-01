%a
divisiblea(X,N):- 0 is X mod N.
distributea([], [], []).
distributea([H|T], [H|L1], L2) :- divisiblea(H,2), divisiblea(H,5), distributea(T, L1, L2).
distributea([H|T], L1, [H|L2]) :- divisiblea(H,8), distributea(T, L1, L2).
distributea([_|T], L1, L2) :- distributea(T, L1, L2). 
% ?- distributea([5,40,120],A,B).

%b1
divisibleb1(X,N):- 0 is X mod N.
distributeb1([], [], []).
distributeb1([H|T], [H|L1], L2) :- divisibleb1(H,2), divisibleb1(H,5), !, distributeb1(T, L1, L2).
distributeb1([H|T], L1, [H|L2]) :- divisibleb1(H,8), distributeb1(T, L1, L2).
distributeb1([_|T], L1, L2) :- distributeb1(T, L1, L2).
% ?- distributeb1([5,40,120],A,B).

%b2
divisibleb2(X,N):- 0 is X mod N.
distributeb2([], [], []).
distributeb2([H|T], [H|L1], L2) :- divisibleb2(H,2), divisibleb2(H,5), distributeb2(T, L1, L2).
distributeb2([H|T], L1, [H|L2]) :- divisibleb2(H,8), !, distributeb2(T, L1, L2).
distributeb2([_|T], L1, L2) :- distributeb2(T, L1, L2).
% ?- distributeb2([5,40,120],A,B).

%b3
divisibleb3(X,N):- 0 is X mod N.
distributeb3([], [], []).
distributeb3([H|T], [H|L1], L2) :- divisibleb3(H,2), !, divisibleb3(H,5), distributeb3(T, L1, L2).
distributeb3([H|T], L1, [H|L2]) :- divisibleb3(H,8), distributeb3(T, L1, L2).
distributeb3([_|T], L1, L2) :- distributeb3(T, L1, L2). 
% ?- distributeb3([5,40,120],A,B).


/*
1 ?- distributea([5,40,120],A,B).
A = [40, 120],
B = [] ;
A = [40],
B = [120] ;
A = [40],
B = [] ;
A = [120],
B = [40] ;
A = [],
B = [40, 120] ;
A = [],
B = [40] ;
A = [120],
B = [] ;
A = [],
B = [120] ;
A = B, B = [].

2 ?- distributeb1([5,40,120],A,B).
A = [40, 120],
B = [].

3 ?- distributeb2([5,40,120],A,B).   
A = [40, 120],
B = [] ;
A = [40],
B = [120] ;
A = [120],
B = [40] ;
A = [],
B = [40, 120].

4 ?- distributeb3([5,40,120],A,B).   
A = [40, 120],
B = [].
*/