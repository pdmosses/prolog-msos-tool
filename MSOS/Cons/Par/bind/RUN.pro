:-ensure_loaded('Cons/Dec/app/RUN.pro').

:-ensure_loaded('ABS.pro').

app(bind(I), BV):'Dec'---U--->map([I+>BV]) :-
        check(I:'I'),
        check(BV:'BV'),
        check(U:'U').

