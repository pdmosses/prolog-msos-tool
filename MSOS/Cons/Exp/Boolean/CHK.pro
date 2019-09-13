:-ensure_loaded('Data/ValueType/ABS.pro').

declare('ValueType'>[bool]).

B:'Exp'===U===>bool :-
        check(B:'B'),
        check(U:'U').

