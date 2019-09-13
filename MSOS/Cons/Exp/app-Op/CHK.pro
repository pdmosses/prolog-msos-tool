:-ensure_loaded('Data/FuncType/ABS.pro').

:-ensure_loaded('Data/PassableType/ABS.pro').

:-ensure_loaded('Data/ValueType/ABS.pro').

:-ensure_loaded('ABS.pro').

declare('FuncType'>func('PassableType', 'ValueType')).

app(O, ARG):'Exp'===U===>VT :-
        check(O:'O'),
        check(ARG:'ARG'),
        check(U:'U'),
        O:'O'===U===>func(PVT, VT),
        check(PVT:'PVT'),
        check(VT:'VT'),
        ARG:'ARG'===U===>PVT.

