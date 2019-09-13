:-ensure_loaded('Data/Passable/ABS.pro').

:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('ABS.pro').

declare('Passable'>'Value').

declare('Value'>tup(*('Value'))).

app(O, ARG):'Exp'---X--->app(O, ARG_1) :-
        check(O:'O'),
        check(ARG:'ARG'),
        ARG:'ARG'---X--->ARG_1,
        check(ARG_1:'ARG').

app(O, tup(Vs)):'Exp'---U--->V_1 :-
        check(O:'O'),
        check(Vs: *('V')),
        check(U:'U'),
        eq(app_op(O, Vs), V_1),
        check(V_1:'V').

app(O, V):'Exp'---U--->V_1 :-
        check(O:'O'),
        check(V:'V'),
        check(U:'U'),
        eq(app_op(O, V), V_1),
        check(V_1:'V').

app(O, tup(V1, V2)):'Exp'---U--->V_1 :-
        check(O:'O'),
        check(V1:'V'),
        check(V2:'V'),
        check(U:'U'),
        eq(app_op(O, V1, V2), V_1),
        check(V_1:'V').

