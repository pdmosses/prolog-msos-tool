% write.pro

/* Writing Prolog clauses corresponding to MSOS declarations
   and rules to the output stream
*/

write_clauses([P|Ps]) :- write_clause(P), nl, write_clauses(Ps).
write_clauses([]).

/* Clauses corresponding to MSOS transition rules contain atoms
   representing Prolog variables, and are written unquoted:
*/
write_clause(H :- G) :- 
	write(H), writeln(' :-'), write_goal(G), writeln('.').
write_clause(PT1---PT2--->PT3) :- 
	write(PT1---PT2--->PT3), writeln('.').
write_clause(msos(M)) :- 
	writeln('/*'), write(M), nl, writeln('*/').

/* Clauses corresponding to MSOS declarations don't contain atoms
   representing Prolog variables, and are written with quotes:
*/
write_clause(P) :- 
	writeq(P), writeln('.').

write_goal(','(G1,G2)) :- tab(8), write(G1), writeln(','), write_goal(G2).
write_goal(A) :- tab(8), write(A).
