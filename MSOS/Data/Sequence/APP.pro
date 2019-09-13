% T* = T+ | null

check(null: *(_)).
check(Z: *(T)) :- check(Z: +(T)).

% T+ = T | [T,T|_]

check(Z: +(T)) :- check(Z:T).
check(Z: +(T)) :-
	Z = [_,_|_],
	checklist(check_is(T), Z).

% T? = T | null

check(null: ?(_)).
check(Z: ?(T)) :- check(Z:T).

eq(^(S1,S2), S) :- 
	S1 == null -> S = S2;
	S2 == null -> S = S1;
	is_list(S1) -> 
	    ( is_list(S2) -> 
		append(S1, S2, S); 
		append(S1, [S2], S) );
	is_list(S2) -> 
	S = [S1|S2];
	S = [S1,S2].

single(Z) :- Z \= null, \+is_list(Z).

seq_concat(null, S, S).
seq_concat(Z1, null, Z1) :- single(Z1).
seq_concat(Z1, Z2, [Z1,Z2]) :- single(Z1), single(Z2).
seq_concat(Z1, [Z2,Z3|S], [Z1,Z2,Z3|S]) :- single(Z1).
seq_concat([Z1,Z2|S1], [Z3,Z4|S2], S3) :- append([Z1,Z2|S1], [Z3,Z4|S2], S3).
seq_concat([Z1,Z2|S1], Z3, S2) :- append([Z1,Z2|S1], [Z3], S2), single(Z3).
seq_concat([Z1,Z2|S], null, [Z1,Z2|S]). 


