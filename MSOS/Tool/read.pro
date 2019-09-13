% read.pro

/* read_chars(Cs) sets Cs to the list of characters read
   from the current input stream
*/

read_chars(Cs) :- 
	get_char(C), nl, show(C), read_rest(C, Cs), nl.

read_rest(end_of_file, []) :- !.
read_rest(C, [C|Cs]) :- get_char(C1), show(C1), read_rest(C1, Cs).

show(end_of_file) :- !.
show(C) :- write(C).


/* lookahead(C) in a DCG parses the empty string, 
   unifying C with the next character to be parsed.
*/

lookahead(C, [C|A], [C|A]).
lookahead(-1, [], []). % end-of-file character

/* not_next("...") in a DCG parses the empty string, 
   provided that the next character to be parsed is not in "..."
*/

not_next(Cs) --> lookahead(C), { \+member(C, Cs) }.

/* up_to("...") in a DCG parses arbitrary text up to and 
   including the first occurrence of the sequence "..."
*/

up_to(Cs) --> Cs, !.
up_to(Cs) --> [_], up_to(Cs).

