% ML/Abs: A sublanguage of Standard ML
% extending ML/Dec with abstractions and recursion

% Peter D. Mosses <pdmosses@brics.dk>
% 12 Sep 2004

% Derived from The Definition of Standard ML (1997).

:- multifile prog/3, exp/3, infexp/3, appexp/3, atexp/3, 
	valbind/3, dec1/3, reserved/1.

:- ensure_loaded('../Dec/SYN.pro').

% Compatible with ../Cmd/SYN

% Application expressions:

appexp(app_seq(E1,E2)) -->
        atexp(E1), i, atexp(E2).

% Abstraction expressions: 

exp(close(abs(PAR, E))) -->
	"fn", i, par(PAR), i, "=>", i, exp(E).

% Parameters:

par(bind(I)) -->
	vid(I).

par(tup(null)) -->
	"(", i, ")".

par(bind(I)) -->
	"(", i, vid(I), i, ")".

par(tup([bind(I)|PARs])) -->
	"(", i, vid(I), i, ",", i, parids(PARs), i, ")".

parids([bind(I)|PARs]) -->
	vid(I), i, ",", i, parids(PARs).

parids([bind(I)]) -->
	vid(I).

% Recursive declarations:

valbind(rec(D)) -->
	"rec", i, valbind(D).

% Function bindings:

dec1(rec(bind(I,close(abs(PAR,E))))) -->
	"fun", i, vid(I), i, par(PAR), i, "=", i, exp(E).

reserved("fn").
reserved("fun").
reserved("rec").
reserved("=>").
