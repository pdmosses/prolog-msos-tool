:-ensure_loaded('Data/Value/ABS.pro').

declare('Value'>'Integer').

cond_nz(E, C):'Cmd'---X--->cond_nz(E_1, C) :-
        check(E:'E'),
        check(C:'C'),
        E:'E'---X--->E_1,
        check(E_1:'E').

cond_nz(0, C):'Cmd'---U--->skip :-
        check(C:'C'),
        check(U:'U').

cond_nz(N, C):'Cmd'---U--->C :-
        check(N:'N'),
        check(C:'C'),
        check(U:'U'),
        eq(N\=0, true).

