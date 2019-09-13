:-ensure_loaded('Data/ValueType/ABS.pro').

declare('ValueType'>[int]).

cond_nz(E, C):'Cmd'===U===>void :-
        check(E:'E'),
        check(C:'C'),
        check(U:'U'),
        E:'E'===U===>int,
        C:'C'===U===>void.

