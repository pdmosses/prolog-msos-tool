% Programs

prog(K:'Prog') --> i, term(T), i, {kernelize(T, K)}.

% Terms:

term(T) --> subterms(Ts), {leftassoc(Ts, T)}.

subterms([T,I|Ts]) --> subterm(T), i, infix(I), i, subterms(Ts).

subterms([T]) --> subterm(T).

subterm(pre(T1,T2)) --> group(T1), i, subterm(T2).

subterm(T) --> group(T).

group(T) --> const(T).

group(T) --> prefix(T).

group(T) --> "(", i, terms(Ts), i, ")",
	{Ts = [T], ! ; T = tuple(Ts)}.

terms([T|Ts]) --> term(T), i, ",", i, terms(Ts).

terms([T]) --> term(T).

infix(and) --> "and".
infix(then) --> "then".
infix(and_then) --> "and-then".
infix(catch) --> "catch".
infix(and_catch) --> "and-catch".
infix(else) --> "else".
infix(scope) --> "scope".
infix(before) --> "before".

prefix(result) --> "result".
prefix(indivisibly) --> "indivisibly".
prefix(unfolding) --> "unfolding".
prefix(maybe) --> "maybe".
prefix(give) --> "give".
prefix(check) --> "check".
prefix(furthermore) --> "furthermore".
prefix(recursively) --> "recursively".
prefix(bound_to) --> "bound-to".
prefix(stored_at) --> "stored-at".
prefix(closure) --> "closure".
prefix(the(S)) --> "the ", i, sort(S).
prefix(sharp(N)) --> "#", digit(D), {number_chars(N, [D])}.

const(copy) --> "copy".
const(throw) --> "throw".
const(skip) --> "skip".
const(fail) --> "fail".
const(choose_nat) --> "choose_nat".
const(copy_bindings) --> "copy-bindings".
const(create) --> "create".
const(inspect) --> "inspect".
const(update) --> "update".
const(destroy) --> "destroy".
const(enact) --> "enact".
const(close) --> "close".
const(apply) --> "apply".
const(current_bindings) --> "current-bindings".
const(N) --> integer(N).

sort(S) --> malnums(As), {name(S, As)}.

% Integers:

integer(N) --> digits(L), !, {number_chars(N, L)}.


% Layout and comments:

i --> optignores.

optignores --> ignore, !, optignores.
optignores --> "".

ignore --> whites.
ignore --> newline.
ignore --> "(*", up_to("*)").

% Left recursion:

leftassoc([T1,I,T2|Ts], T) :- 
	leftassoc([inf(T1,I,T2)|Ts], T).

leftassoc([T], T).

% Expansion to AN-2/Kernel:

kernelize(inf(T1,I,T2), K) :-
	kernelize(T1, K1), kernelize(T2, K2),
	(   kernel(I) -> K =..[I,K1,K2]
	;   expand(inf(T1,I,T2), K) 
	).

kernelize(pre(T1,T2), K) :-
	kernelize(T1, K1), kernelize(T2, K2),
	(   prefix(K1), \+kernel(K1) -> expand(pre(K1,K2), K)
	;   \+prefix(K1) -> expand(pre(give,K2), K3), K = then(K3,K1)
	;   expand(pre(K1,K2), K)
	).

kernelize(T, K) :-
	(   const(T), \+kernel(T) -> expand(T, K)
	;   K = T
	).
	

kernel(I) :- I \= before.

expand(inf(K1,before,K2),
       then(then(and(K1, copy_bindings),
		 and(scope(give('/'),K2),
		     give(sharp(1)))),
	    give('/'))).

expand(pre(furthermore,K2),
       then(and(K2,copy_bindings),
	    give('/'))).


