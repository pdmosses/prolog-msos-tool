:-ensure_loaded('Data/ValueType/ABS.pro').

declare('ValueType'>[int]).

N:'Exp'===U===>int :-
        check(N:'N'),
        check(U:'U').

