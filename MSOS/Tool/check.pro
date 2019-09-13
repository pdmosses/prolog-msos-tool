% check.pro

/* check(V:T) is defined in Data/T/APP for all built-in types T
*/

check(V:[V]).

check(V:T) :- declare(T>S), check(V:S), !.

check(V:T) :- declare(T=S), !, check(V:S), !.

check(V:VT) :- declare(VT:T), !, check(V:T), !.

check(V:T) :-
	V =.. [F|Vs], T =.. [F|Ts],
% speedup ~ 10::1 (full checks) by removing:
	(   current_prolog_flag(check_nested, true) ->
	maplist(check_pair, Vs, Ts), ! ;
	true ).

check_nested :- set_prolog_flag(check_nested, true).
no_check_nested :- set_prolog_flag(check_nested, false).

check(T>S) :- declare(T>S).
check(T>S) :- declare(T>R), check(R>S).

check_pair(V, T) :- check(V:T).

check_is(T, V) :- check(V:T).


/* States: */

final(S) :- check(S:'Final').

S:VT---L--->S1 :- declare(VT:T), S:T---L--->S1.

S:VT===L===>S1 :- declare(VT:T), S:T===L===>S1.


/* Labels: */

check(X:'Unobs') :- unobs(X).

declare('U':'Unobs').
declare('X':'Label').

% eq_label(X, [...|R]) holds when X contains ... and R is the rest of X

eq_label(X, L) :-
	var(L) -> X = L ;
	L=[H|T],
	select(H, X, R),
	eq_label(R, T).
