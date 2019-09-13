:-ensure_loaded('ABS.pro').

app_seq(E, ARG):'Exp'---X--->app_seq(E_1, ARG) :-
        check(E:'E'),
        check(ARG:'ARG'),
        E:'E'---X--->E_1,
        check(E_1:'E').

app_seq(V, ARG):'Exp'---X--->app_seq(V, ARG_1) :-
        check(V:'V'),
        check(ARG:'ARG'),
        ARG:'ARG'---X--->ARG_1,
        check(ARG_1:'ARG').

app_seq(V, PV):'Exp'---U--->app(V, PV) :-
        check(V:'V'),
        check(PV:'PV'),
        check(U:'U').

