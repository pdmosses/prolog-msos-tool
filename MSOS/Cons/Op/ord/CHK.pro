:-ensure_loaded('Data/PassableType/ABS.pro').

:-ensure_loaded('Data/ValueType/ABS.pro').

declare('PassableType'>[bool]).

declare('ValueType'>[int]).

ord:'Op'===U===>func(bool, int) :-
        check(U:'U').

