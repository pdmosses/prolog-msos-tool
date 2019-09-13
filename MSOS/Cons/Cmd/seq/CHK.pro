:-ensure_loaded('ABS.pro').

seq(C1, C2):'Cmd'===U===>void :-
        check(C1:'C'),
        check(C2:'C'),
        check(U:'U'),
        C1:'C'===U===>void,
        C2:'C'===U===>void.

