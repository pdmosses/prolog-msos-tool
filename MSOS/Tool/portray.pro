% portray.pro

/* Pretty printing of abstract syntax trees
*/

pretty :- set_prolog_flag(pretty, true).
plain :- set_prolog_flag(pretty, false).

lined :- set_prolog_flag(lined, true).
unlined :- set_prolog_flag(lined, false).

portray(T) :-
	(   current_prolog_flag(pretty, true) 
	->  print_tree(T,0), !
	;   write(T)
	).

print_nl_tree(T) :- print_nl_tree(T, 0).

print_nl_tree(T, N) :-
	indent(N), print_tree(T, N).

show_label :- set_prolog_flag(label, true).
hide_label :- set_prolog_flag(label, false).

print_label(X) :-
	(   current_prolog_flag(label, true) 
	->  write(' { '), print_list(X,1), write(' } '), nl
	;   true
	).

show_parse :- set_prolog_flag(parsetree, true).
hide_parse :- set_prolog_flag(parsetree, false).

print_parse(X) :-
	(   current_prolog_flag(parsetree, true) 
	->  print_nl_tree(X), nl, nl
	;   true
	).

/* print_tree(T, N) assumes already at column 2N, 
   prints T in columns >= 2N, ending at column >= 2N.
*/

print_tree(T) :-
	print_tree(T, 0).
 
print_tree(T, N) :-
	(   atomic(T)
	->  write(T)
	;   T == []
	->  write('[ ]')
	;   T = T1:S
	->  print_tree(T1, N), indent(N), 
	    write(':'), print_tree(S, N)
	;   is_list(T)
	->  write('[ '), N1 is N+1, 
	    print_list(T, N1),
	    write(' ]') 
	;   T =.. [F, T1, T2], current_op(_,xfx,F), short(T1), short(T2)
	->  print_tree(T1, N), print_op(F), print_tree(T2, N) 
	;   T =.. [F, T1, T2], current_op(_,xfx,F), short(T1)
	->  print_tree(T1, N), print_op(F), N1 is N+1,
	    print_nl_tree(T2, N1) 
	;   T =.. [F, T1], short(T1)
	->  write(F), write('('), print_tree(T1 ,N), write(')')
	;   T =.. [F, T1, T2], short(T1), short(T2)
	->  write(F), write('('), print_tree(T1, N), write(', '), 
	                          print_tree(T2, N),  write(')')
	;   T =.. [F|L]
	->  write(F), indent(N), 
	    write('( '), N1 is N+1,
	    print_list(L, N1), write(' )')
	;   write(T)
	).

print_op(F) :-
	F == '+>' -> write(' |-> ') ;
	F == '+=' -> write('\' = ') ;
        write(' '), write(F), write(' ').

short([]).
short(T) :- atomic(T).
short([T]) :- short(T).
short([T1, T2]) :- atomic(T1), short(T2).
short(T) :- T =.. [_, T1], short(T1).
short(T) :- T =.. [_, T1, T2], atomic(T1), short(T2).
short(T) :- T =.. [_, T1, T2, T3], atomic(T1), short(T2), short(T3).

/* print_list(L, N) assumes already at column 2N,
   prints elements of L on separate lines starting at column 2N,
   terminating each line except the last with a comma.
   A list consisting of two atoms is printed on one line.
*/

print_list([], _N).

print_list([H], N) :-
	print_tree(H, N).

print_list([H1, H2], N) :-
	atomic(H1), atomic(H2),
	print_tree(H1, N), write(', '), print_tree(H2, N).

print_list([H|L], N) :-
	print_tree(H, N), write(','), indent(N),
	print_list(L, N).

indent(N) :-
	(   N =< 0 -> nl, tab(4)
	;   N1 is N-1, indent(N1), indent
	).

% indent may be redefined, e.g. to write('    ')

indent :-
	(   current_prolog_flag(lined, false) -> write('  ')
	;   write('| ')
	).

