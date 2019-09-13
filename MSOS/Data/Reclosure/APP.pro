eq(reclose(ENV,ENV1,map([I+>CLO|L])), 
   map([I+>reclosure(ENV,ENV1,CLO)|L_1])) :-
	eq(reclose(ENV,ENV1,map(L)), map(L_1)).

eq(reclose(_ENV,_ENV1,map([])), map([])).
