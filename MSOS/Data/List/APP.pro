/* [Z1,...,Zn] is represented by list(L)
   where L lists Z1,...,Zn in that order
*/

check(list(L):'List'(T)) :-
	is_list(L),
	checklist(check_is(T), L).

eq(list(null), list([])).
eq(list(Z), list([Z])) :- single(Z).
eq(list(L), list(L)) :- is_list(L).

eq(+(list(L1),list(L2)), list(L)) :-
	append(L1, L2, L).
eq(first(list([Z|_])), Z).
eq(rest(list([_|L])), L).
eq(last(list(L)), Z) :- 
	last(Z, L).
eq(front(list(L)), L1) :- 
	append(L1, [_], L).
eq(length(list(L)), N) :- 
	length(L, N).

eq(nth(list(L),N),Z) :- nth1(N, L, Z).
eq(cons(Z,list(L)), list([Z|L])).
