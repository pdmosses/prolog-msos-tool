% ML/Dec: A sublanguage of Standard ML
% extending ML/Exp with declarations

% Peter D. Mosses <pdmosses@brics.dk>
% 12 Sep 2004

% Derived from The Definition of Standard ML (1997).

:- multifile prog/3, atexp/3, reserved/1.

:- ensure_loaded('../Exp/SYN.pro').

% Programs

prog(D:'Prog') -->
        i, topdecs(D), i.

% Top-level declarations:

topdecs(accum(D1,D2)) -->
	topdec(D1), i, ";", i, topdecs(D2).

topdecs(D) -->
	topdec(D), i, ";".

topdec(D) -->
	dec1(D).

topdec(bind(id(it),E)) -->
	exp(E).

% Declarations:

dec(D) -->
	dec1(D).

dec(accum(D1,D2)) -->
	dec1(D1), i, ";", i, dec(D2) ;
	dec1(D1), i, dec(D2).

dec1(D) -->
	"val", i, valbind(D).

dec1(local(D1,D2)) -->
	"local", i, dec(D1), i, "in", i, dec(D2), i, "end".

% Value bindings:

valbind1(bind(I,E)) -->
	vid(I), i, "=", i, exp(E).

valbind(D) -->
	valbind1(D).

valbind(simult_seq(D1,D2)) -->
	valbind1(D1), i, "and", i, valbind(D2).

% Expressions:

atexp(local(D,E)) -->
	"let", i, dec(D), i, "in", i, exp(E), i, "end".

reserved("and").
reserved("end").
reserved("in").
reserved("let").
reserved("local").
reserved("val").
