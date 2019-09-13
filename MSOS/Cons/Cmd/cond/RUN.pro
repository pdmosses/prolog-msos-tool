:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('ABS.pro').

declare('Value'>'Boolean').

cond(E, C1, C2):'Cmd'---X--->cond(E_1, C1, C2) :-
        check(E:'E'),
        check(C1:'C'),
        check(C2:'C'),
        E:'E'---X--->E_1,
        check(E_1:'E').

cond(true, C1, C2):'Cmd'---U--->C1 :-
        check(C1:'C'),
        check(C2:'C'),
        check(U:'U').

cond(false, C1, C2):'Cmd'---U--->C2 :-
        check(C1:'C'),
        check(C2:'C'),
        check(U:'U').

