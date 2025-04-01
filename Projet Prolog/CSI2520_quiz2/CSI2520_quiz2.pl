power(_, 0, 1).
power(X, N, Y) :-
    N > 0,
    N1 is N - 1,
    power(X, N1, Y1),
    Y is X * Y1.


gSeries(X,Y):-gSeries(X,0,Y).
gSeries(X,N,Y):-power(X,N,Y).
gSeries(X,N,Y):- N1 is N+1, gSeries(X,N1,Y).

/*
1 ?- gSeries(3,Y).
Y = 1 ;
Y = 3 ;
Y = 9 ;
Y = 27 ;
Y = 81 ;
Y = 243 ;
Y = 729 ;
Y = 2187 ;
Y = 6561.
*/