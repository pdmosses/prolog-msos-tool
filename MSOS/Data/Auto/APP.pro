:- ensure_loaded([
	'Data/Atom/APP.pro', 
	'Data/Boolean/APP.pro', 
	'Data/Character/APP.pro', 
	'Data/Integer/APP.pro',
	'Data/Set/APP.pro',
	'Data/List/APP.pro',
	'Data/Map/APP.pro',
	'Data/Sequence/APP.pro',
	'Data/Store/APP.pro',
	'Data/Channel/APP.pro']).


/* Applying unary and binary operations: */

eq(app_op(O, V1), V) :-
	atom(O), T =.. [O, V1], eq(T, V).

eq(app_op(O, V1, V2), V) :-
	T =.. [O, V1, V2], eq(T, V).

eq(T, V) :-
	T =.. [O,L], is_list(L), T1 =.. [O|L], eq(T1, V).


% Generic iteration of +:

eq(sigma([A]), A).
eq(sigma([A,B|L]), D) :- eq(+(A,B), C), eq(sigma([C|L]), D).
