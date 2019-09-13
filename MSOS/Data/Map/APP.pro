/* S1+>T1,...,Sn+>Tn is represented by map(L)
   where L lists S1+>T1,...,Sn+>Tn in any order
*/

check(map(L):'Map'(S,T)) :-
	is_list(L),
	checklist(check_is(S+>T), L).

check((X+>Y):(S+>T)) :-
	check(X:S), check(Y:T).

eq(lookup(X,map(L)), Y) :-
	memberchk(X+>Y, L).

eq(dom(map(L)), set(S)) :-
	maplist(map_x, L, S).
eq(ran(map(L)), set(S)) :-
	maplist(map_y, L, S).
map_x(X+>_, X).
map_y(_+>Y, Y).

eq(void, map([])).

eq(+(map(L1),map(L2)), map(L)) :-
	maplist(map_x, L1, S1),
	maplist(map_x, L2, S2),
	intersection(S1, S2, []),
	append(L1, L2, L).

eq(-(map(L1),set(L2)), map(L)) :-
	sublist(map_x_not_in(L2), L1, L).
map_x_not_in(L, X+>_) :- 
	\+member(X, L).

eq(/(map(L1),map(L2)), map(L)) :-
	maplist(map_x, L1, S1),
	sublist(map_x_not_in(S1), L2, L3),
	append(L1, L3, L).
