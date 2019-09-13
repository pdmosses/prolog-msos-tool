eq(not(true), false).
eq(not(false), true).
eq(and(true,X), X).
eq(and(false,_), false).
eq(or(true,_), true).
eq(or(false,X), X).
eq(=(X,X), true).
eq(=(true,false), false).
eq(=(false,true), false).
eq(\=(X,Y), B) :- eq(=(X,Y), B1), eq(not(B1), B).
