:-ensure_loaded('Data/PassableType/ABS.pro').

:-ensure_loaded('Data/ValueType/ABS.pro').

declare('PassableType'>'ValueType').

E:'Arg'===U===>VT :-
        check(E:'E'),
        check(U:'U'),
        E:'E'===U===>VT,
        check(VT:'VT').

