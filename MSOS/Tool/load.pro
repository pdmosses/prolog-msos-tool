% load.pro

% Peter D. Mosses <pdmosses@brics.dk>

/* Top level for parsing MSOS specifications in MSDF
   and translating them to programs in Prolog

   USAGE: (see also ABOUT.txt)

   cd $HOME/Projects/SVN/MSOS
   swipl
   
   cd('$HOME/Projects/SVN/MSOS').

   ['Tool/load.pro'].

   parse('Test/bc', 'Test/bc/4.bc').
   check('Test/bc', 'Test/bc/4.bc').
   run('Test/bc', 'Test/bc/4.bc').

   % can use program text "..." instead of filename 'Test/bc/4.bc' 

   % can use modular version 'Lang/bc/1' instead of 'Test/bc'

   cons('Cmd'), cons('Cmd/seq'), ... (re)generates pl from msdf

   test('bc'), lang('bc/1'), ... (re)generates pl from msdf
 
*/ 

:- set_prolog_flag(double_quotes, chars).

:- set_prolog_flag(pretty, true).

:- set_prolog_flag(lined, false).

:- set_prolog_flag(label, true).

:- set_prolog_flag(parsetree, true).

:- set_prolog_flag(check_nested, false).

:- op(700, xfx, (+>)).
:- op(700, xfx, (+=)).
:- op(750, xfy, (---)).
:- op(750, xfy, (===)).
:- op(800, xfx, (--->)).
:- op(800, xfx, (===>)).
:- op(800, xfx, (--->*)).
:- op(800, xfx, (>*)).


:- ensure_loaded('Tool/read.pro').
:- ensure_loaded('Tool/portray.pro').
:- ensure_loaded('Tool/write.pro').

:- ensure_loaded('Lang/Lex/LEX.pro').
:- ensure_loaded('Lang/MSDF/SYN.pro').

:- ensure_loaded('Tool/translate.pro').

:- multifile     check/1, declare/1, eq/2.
:- discontiguous check/1, declare/1, eq/2.

:- ensure_loaded('Data/Auto/ABS.pro').
:- ensure_loaded('Data/Auto/APP.pro').

:- multifile     readable/1, writable/1.
:- discontiguous readable/1, writable/1.

:- ensure_loaded('Tool/computations.pro').
:- ensure_loaded('Tool/check.pro').

:- multifile     (--->)/2, (===>)/2.
:- discontiguous (--->)/2, (===>)/2.

load_msos(MN, A) :-
	concat_atom([MN, '/', A, '.pro'], B),
 	(   exists_file(B) -> ensure_loaded(B)
	;   concat_atom(['Lang/', B], C), 
	    exists_file(C) -> ensure_loaded(C)
	;   nl, write(B), writeln(' not found'), fail
	).

load_msos_option(MN, A) :-
	concat_atom([MN, '/', A, '.pro'], B),
	(   exists_file(B) -> ensure_loaded(B)
	;   concat_atom(['Lang/', B], C), 
	    exists_file(C) -> ensure_loaded(C)
	;   true
	).

read_string(MN, A, S) :-
	is_list(A) -> S = A ;
	(   exists_file(A) -> C = A
	;   concat_atom(['Test/', MN, '/', A], B), 
	    exists_file(B) -> C = B
	;   concat_atom(['Lang/', LMN], MN),
	    concat_atom(['Test/', LMN, '/', A], B), 
	    exists_file(B) -> C = B
	;   nl, write(A), writeln(' not found'), fail
	),
	see(C), read_chars(S), seen.

accept(MN, A) :-
	load_msos(MN, 'CFG'),
	read_string(MN, A, S),
	phrase(prog, S),
	writeln('Parsed OK').

parse(MN, S) :- parse(MN, S, _).

parse(MN, A, T) :-
	load_msos(MN, 'ABS'),
	load_msos(MN, 'SYN'),
	read_string(MN, A, S),
	phrase(prog(T), S),
	print_parse(T),
	(    check(T) -> writeln('Parsed OK')
	;   writeln('ABS check failed')
	).

check(MN, A) :-
	load_msos(MN, 'ABS'),
	load_msos(MN, 'SYN'),
	load_msos(MN, 'CHK'),
	load_msos_option(MN, 'CHK-init'),
	parse(MN, A, T), !,
	big_step(T).

run(MN, A) :-
	load_msos(MN, 'ABS'),
	load_msos(MN, 'SYN'),
	load_msos(MN, 'RUN'),
	load_msos_option(MN, 'RUN-init'),
	parse(MN, A, T), !,
	small_steps(T).

run(MN, A, N, M) :-
	load_msos(MN, 'ABS'),
	load_msos(MN, 'SYN'),
	load_msos(MN, 'RUN'),
	load_msos_option(MN, 'RUN-init'),
	read_string(MN, A, S),
	phrase(prog(T), S), !,
	small_steps(T, N, M).

run(MN, A, N) :- run(MN, A, N, N).

small_steps(T) :-
        run_label(X),
        T ---X--->* F, nl,
        write('--'), print_label(X), 
	write('->*'), print_nl_tree(F).

small_steps(T, N) :-
        run_label(X),
        T ---X---N>* SN, nl,
        write('--'), print_label(X), 
	write('-'), print(N), write('>*'), print_nl_tree(SN), !,
	\+final(SN).

small_steps(T, N, M) :-
	small_steps(T, M),
	(   M < N 
	->  M1 is M+1, small_steps(T, N, M1)
	;   true ).
	

big_step(T) :-
        chk_label(X),
        T ===X===> F, nl,
        write('=='), print_label(X), write('=>'), 
        print_nl_tree(F).


read_msdf(Ms, MN, A) :-
	concat_atom([MN, '/', A, '.msdf'], F), read_phrase(msos(Ms), F).

read_msdf_pl(Ms, MN, A) :-
	read_msdf(Ms, MN, A), !, msdf2clauses(A, Ms, Ps), !, 
%	write_clauses(Ps), 
	concat_atom([MN, '/', A, '.pro'], F), 
%	atom_concat(F, '~', G),
%	(   exists_file(G) -> delete_file(G) ; true ),
%	(   exists_file(F) -> rename_file(F, G) ; true ),
	tell(F), write_clauses(Ps), told, ensure_loaded(F).

msdf(M, A) :-
	nl, write('Processing '),
	write(M), write('/'), write(A), writeln(' ... '),
	read_msdf_pl(_, M, A),
	write(M), write('/'), write(A), writeln(' OK').

cons(MN) :-
	concat_atom(['Cons/', MN], M),
	(   msdf(M, 'ABS') ; true ),
	(   msdf(M, 'CHK') ; true ),
	(   msdf(M, 'RUN') ; true ).


lang(MN) :-
	concat_atom(['Lang/', MN], M),
	(   msdf(M, 'ABS') ; true ),
	(   msdf(M, 'CHK') ; true ),
	(   msdf(M, 'RUN') ; true ).


test(MN) :-
	concat_atom(['Test/', MN], M),
	(   msdf(M, 'ABS') ; true ),
	(   msdf(M, 'CHK') ; true ),
	(   msdf(M, 'RUN') ; true ).

data(MN) :-
	concat_atom(['Data/', MN], M),
	msdf(M, 'ABS').



% OBSOLESCENT QUERIES

% The following queries assume that a language has already been loaded.

/* read_phrase(T, F) parses the text in the file named F
   as indicated by the term T
*/

read_phrase(T, F) :-
	(   exists_file(F) 
	-> see(F), read_chars(S), seen, !, phrase(T, S)
	;   write(F), writeln(' not found'), fail
	).

/* Combining parsing a program with checking or running it:
*/

chk(T) :- big_step(T).

prog_chk(T, S) :-
	phrase(prog(T), S), !, chk(T).

read_prog_chk(T, F) :-
	read_phrase(prog(T), F), !, chk(T).

run(T) :- small_steps(T).

prog_run(T, S) :-
	phrase(prog(T), S), !, run(T).

read_prog_run(T, F) :-
	read_phrase(prog(T), F), !, run(T).



/* ms2pl(P, [MN1,...,MNk]) calls msos2pl(_, P/MNi) for i=1..k
*/

msdf2pl(_P,[]).
msdf2pl(P,[MN|MNs]) :- 
	atom_concat(P, MN, MN1), read_msdf_pl(_, MN1), msdf2pl(P,MNs).
