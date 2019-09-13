:-ensure_loaded('Data/Value/ABS.pro').

declare('Value'>'Boolean').

cond(E, E1, E2):'Exp'---X--->cond(E_1, E1, E2) :-
        check(E:'E'),
        check(E1:'E'),
        check(E2:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

cond(true, E1, E2):'Exp'---U--->E1 :-
        check(E1:'E'),
        check(E2:'E'),
        check(U:'U').

cond(false, E1, E2):'Exp'---U--->E2 :-
        check(E1:'E'),
        check(E2:'E'),
        check(U:'U').

