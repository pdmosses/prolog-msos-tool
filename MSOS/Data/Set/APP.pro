/* {Z1,...,Zn} is represented by set(L)
   where L lists Z1,...,Zn in any order
*/

check(set(L):'Set'(T)) :-
	is_set(L),
	checklist(check_is(T), L).

eq(in(Z,set(L)), B) :-
	member(Z, L) -> B=true; B=false.
eq(+(set(L1),set(L2)), set(L)) :-
	union(L1, L2, L).
eq(-(set(L1),set(L2)), set(L)) :-
	subtract(L1, L2, L).
eq(*(set(L1),set(L2)), set(L)) :-
	intersection(L1, L2, L).
eq(=<(set(L1),set(L2)), B) :-
	subset(L1, L2) -> B=true; B=false.
eq(=(set(L1),set(L2)), B) :-
	subset(L1, L2), subset(L2, L1) -> B=true; B=false.
