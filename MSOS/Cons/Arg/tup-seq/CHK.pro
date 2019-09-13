:-ensure_loaded('Data/PassableType/ABS.pro').

:-ensure_loaded('Data/ValueType/ABS.pro').

declare('PassableType'>tup('ValueType', 'ValueType')).

tup_seq(E1, E2):'Arg'===U===>tup(VT1, VT2) :-
        check(E1:'E'),
        check(E2:'E'),
        check(U:'U'),
        E1:'E'===U===>VT1,
        check(VT1:'VT'),
        E2:'E'===U===>VT2,
        check(VT2:'VT').

