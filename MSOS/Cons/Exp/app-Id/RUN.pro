:-ensure_loaded('ABS.pro').

app(I, ARG):'Exp'---U--->app(I_1, ARG) :-
        check(I:'I'),
        check(ARG:'ARG'),
        check(U:'U'),
        I:'I'---U--->I_1,
        check(I_1:'I').

app(I, ARG):'Exp'---X--->app(I, ARG_1) :-
        check(I:'I'),
        check(ARG:'ARG'),
        ARG:'ARG'---X--->ARG_1,
        check(ARG_1:'ARG').

