check(Z:'Integer') :- integer(Z).

eq(+(N1,N2),   N) :- integer(N1), integer(N2), N is N1+N2.
eq(-(N1,N2),   N) :- integer(N1), integer(N2), N is N1-N2.
eq(*(N1,N2),   N) :- integer(N1), integer(N2), N is N1*N2.
eq(div(N1,N2), N) :- integer(N1), integer(N2), N is N1//N2.
eq(mod(N1,N2), N) :- integer(N1), integer(N2), N is N1 mod N2.
eq(rem(N1,N2), N) :- integer(N1), integer(N2), N is N1 rem N2.

eq(ord(false), 0).
eq(ord(true), 1).

eq(<(N1,N2),   B) :- integer(N1), integer(N2), (N1<N2   -> B=true; B=false).
eq(=<(N1,N2),  B) :- integer(N1), integer(N2), (N1=<N2  -> B=true; B=false).
eq(>(N1,N2),   B) :- integer(N1), integer(N2), (N1>N2   -> B=true; B=false).
eq(>=(N1,N2),  B) :- integer(N1), integer(N2), (N1>=N2  -> B=true; B=false).
eq(=(N1,N2),   B) :- integer(N1), integer(N2), (N1=:=N2 -> B=true; B=false).
eq(\=(N1,N2),  B) :- integer(N1), integer(N2), (N1=\=N2 -> B=true; B=false).
