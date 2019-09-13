:-ensure_loaded('Data/ValueType/ABS.pro').

declare('ValueType'>[int]).

while_nz(E, C):'Cmd'===U===>void :-
        check(E:'E'),
        check(C:'C'),
        check(U:'U'),
        E:'E'===U===>int,
        C:'C'===U===>void.

