howMany(X,[],0).
howMany(X,[X|L],N):- howMany(X,L,N1), N is N1+1.
howMany(X,[Y|L],N):- howMany(X,L,N).