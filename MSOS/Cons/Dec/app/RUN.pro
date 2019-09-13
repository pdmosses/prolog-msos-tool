:-ensure_loaded('ABS.pro').

app(PAR, ARG):'Dec'---X--->app(PAR, ARG_1) :-
        check(PAR:'PAR'),
        check(ARG:'ARG'),
        ARG:'ARG'---X--->ARG_1,
        check(ARG_1:'ARG').

