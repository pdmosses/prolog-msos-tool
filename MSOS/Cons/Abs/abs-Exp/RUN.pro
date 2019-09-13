:-ensure_loaded('Cons/Dec/local/RUN.pro').

:-ensure_loaded('Cons/Dec/app/RUN.pro').

:-ensure_loaded('ABS.pro').

app(abs(PAR, E), PV):'Exp'---U--->local(app(PAR, PV), E) :-
        check(PAR:'PAR'),
        check(E:'E'),
        check(PV:'PV'),
        check(U:'U').

