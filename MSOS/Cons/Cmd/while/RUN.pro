:-ensure_loaded('Cons/Cmd/cond/RUN.pro').

:-ensure_loaded('Cons/Cmd/seq/RUN.pro').

while(E, C):'Cmd'---U--->cond(E, seq(C, while(E, C)), skip) :-
        check(E:'E'),
        check(C:'C'),
        check(U:'U').

