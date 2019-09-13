:- ensure_loaded('ABS.pro').
:- ensure_loaded('SYN.pro').
:- ensure_loaded('RUN.pro').

run_label([
	    env= map([ id(a) +> cell(1) ,
		       id(b) +> cell(2) ]) , 
	    store= map([ cell(1) +> 0 ,
	                 cell(2) +> 0 ]) , 
	    store+= _ , 
	    out+= _
	   ]).
