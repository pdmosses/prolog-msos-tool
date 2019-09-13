:-ensure_loaded('Cons/Dec/local/RUN.pro').

:-ensure_loaded('Cons/Abs/RUN.pro').

:-ensure_loaded('ABS.pro').

app(closure(D, ABS), PV):'Exp'---U--->local(D, app(ABS, PV)) :-
        check(D:'D'),
        check(ABS:'ABS'),
        check(PV:'PV'),
        check(U:'U').

