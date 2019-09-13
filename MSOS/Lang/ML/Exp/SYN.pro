% ML/Exp: A sublanguage of Standard ML
% with expressions only

% Peter D. Mosses <pdmosses@brics.dk>
% 20 Sep 2004

% Derived from The Definition of Standard ML (1997).

:- ensure_loaded('Lang/Lex/LEX.pro').

% Programs

prog(E:'Prog') --> i, exp(E), i.

% Expressions

exp(E) --> 
	infexp(E).

exp(cond(E1,E2,E3)) -->
	"if", i, exp(E1), i, "then", i, 
	exp(E2), i, "else", i, exp(E3).

exp(cond(E1,E2,false)) -->
	atexp(E1), i, "andalso", i, exp(E2).

exp(cond(E1,true,E2)) -->
	atexp(E1), i, "orelse", i, exp(E2).

% Infix expressions:

infexp(E) --> 
	appexp(E).

infexp(app(I,tup_seq([E1,E2]))) -->
	atexp(E1), i, vid(I), i, atexp(E2). 

% Application expressions:

appexp(E) --> 
	atexp(E).

appexp(app(I,E)) -->
        vid(I), i, atexp(E). 

appexp(app(nth,tup([app(list,E),N]))) -->
        selop(nth(N)), i, atexp(E). 

% Atomic expressions:

atexp(C) -->
	scon(C).

atexp(I) -->
	vid(I).

atexp(I) -->
	"op", i, vid(I).

atexp(tup(null)) -->
	"(", i, ")".

atexp(E1) -->
	"(", i, exp(E1), i, ")".

atexp(tup_seq([E1|ES2])) -->
	"(", i, exp(E1), ",", i, exps(ES2), i, ")".

atexp(list([])) -->
	"[", i, "]".

atexp(app(list, E)) -->
	"[", i, exp(E), i, "]".

atexp(app(list, tup_seq([E1|ES2]))) -->
	"[", i, exp(E1), ",", i, exps(ES2), i, "]".

% Expression lists:

exps([E|ES]) -->
	exp(E), i, ",", i, exps(ES).

exps([E]) -->
	exp(E).

% Operations:

selop(nth(N)) -->
	"#", integer(N).

% Constants:

scon(N) -->
	integer(N).

scon(N1) -->
	"~", integer(N), {N1 is -N}.

scon(list(L)) -->
	string(L).

scon(C) -->
	"#", string([C]).

% Identifiers:

reserved("andalso").
reserved("else").
reserved("if").
reserved("op").
reserved("orelse").
reserved("then").

vid(id(I)) --> alpha(C), optcsyms(L), lookahead(C1),
  {\+char_type(C1, csym), \+reserved([C|L]), name(I, [C|L])}, !.

vid(id(I)) --> symbols(L), lookahead(C1),
  {\+member(C1,"!%&$#+-/:<=>?@\\~`^|*"), \+reserved(L), name(I, L)}, !.

symbols([C|L]) --> symbol(C), optsymbols(L).

optsymbols(L)   --> symbols(L).
optsymbols([]) --> "".

symbol(C) --> [C], {member(C,"!%&$#+-/:<=>?@\\~`^|*")}.

% Integers:

integer(N) --> digits(L), !, {number_chars(N, L)}.

% Strings:

string(L) --> "\"", optchars(L), "\"".

optchars(L) --> chars(L).
optchars([]) --> "".

chars([C|L]) --> char(C), optchars(L).

char(C) --> graph(C), {C \= '"'}.
char(' ') --> " ".

% Layout and comments:

i --> optignores.

optignores --> ignore, !, optignores.
optignores --> "".

ignore --> whites.
ignore --> newline.
ignore --> "(*", up_to("*)").

