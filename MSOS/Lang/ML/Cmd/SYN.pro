% ML/Cmd: A sublanguage of Standard ML
% extending ML/Dec with command-like expressions

% Peter D. Mosses <pdmosses@brics.dk>
% 12 Sep 2004

% Derived from The Definition of Standard ML (1997).

:- multifile prog/3, exp/3, infexp/3, appexp/3, atexp/3, 
	reserved/1.

:- ensure_loaded('../Dec/SYN.pro').

% Expressions:

exp(seq(while(E1,effect(E2)),tup(null))) -->
	"while", i, exp(E1), i, "do", i, exp(E2).

atexp(seq(effect(E1),E2)) -->
	"(", i, exp(E1), i, ";", i, exp(E2), i, ")".

atexp(seq(seq(Cs),E2)) -->
	"(", i, expseq2(Cs), i, ";", i, exp(E2), i, ")".

infexp(seq(E1,effect(E2))) -->
	atexp(E1), i, "before", i, atexp(E2). 

infexp(seq(effect(assign_seq(deref(E1),E2)),tup(null))) -->
	atexp(E1), i, ":=", i, atexp(E2). 

appexp(ref(alloc(E))) -->
        "ref", i, atexp(E). 

atexp(assigned(deref(E))) -->
        "!", i, atexp(E). 

% Commands:

expseq([effect(E)]) -->
	exp(E).

expseq([effect(E)|Cs]) -->
	exp(E), i, ";", i, expseq(Cs).

expseq2([effect(E)|Cs]) -->
	exp(E), i, ";", i, expseq(Cs).

reserved("before").
reserved("do").
reserved("ref").
reserved("while").
reserved(":=").
reserved("!").
