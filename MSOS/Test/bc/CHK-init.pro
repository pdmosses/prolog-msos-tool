:- ensure_loaded('ABS.pro').
:- ensure_loaded('SYN.pro').
:- ensure_loaded('CHK.pro').

chk_label([
	    env=map([ id(a) +> ref(int) , 
		      id(b) +> ref(int) ])
	   ]).
