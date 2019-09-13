:-ensure_loaded('Cons/Cmd/cond-nz/RUN.pro').

:-ensure_loaded('Cons/Cmd/seq/RUN.pro').

while_nz(E, C):'Cmd'---U--->cond_nz(E, seq(C, while_nz(E, C))) :-
        check(E:'E'),
        check(C:'C'),
        check(U:'U').

