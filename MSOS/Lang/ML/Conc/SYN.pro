% ML/Conc: A sublanguage of Concurrent ML
% extending ML/Abs with simple concurrency primitives

% Peter D. Mosses <pdmosses@brics.dk>
% 29 Sep 2004

:- multifile appexp/3, dec1/3, reserved/1.

:- ensure_loaded('../Abs/SYN.pro').
:- ensure_loaded('../Cmd/SYN.pro').

prog(quiet(effect(E)):'Sys') -->
	i, "cml", i, exp(E), i.

% Application expressions:

appexp(seq(start(E),tup(null))) -->
	"spawn", i, atexp(E).

appexp(seq(send_chan_seq(E1,E2),tup(null))) -->
	"send", i, atexp(tup_seq([E1,E2])).

appexp(recv_chan(E)) -->
	"receive", i, atexp(E).

% Declarations:

dec1(bind(I,alloc_chan)) -->
	"chan", i, vid(I).

reserved("chan").
reserved("cml").
reserved("receive").
reserved("send").
reserved("spawn").
