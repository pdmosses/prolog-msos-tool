:-ensure_loaded('ABS.pro').

seq(C1, C2):'Cmd'---X--->seq(C1_1, C2) :-
        check(C1:'C'),
        check(C2:'C'),
        C1:'C'---X--->C1_1,
        check(C1_1:'C').

seq(skip, C2):'Cmd'---U--->C2 :-
        check(C2:'C'),
        check(U:'U').

