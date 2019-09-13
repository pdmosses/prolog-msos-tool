seq(E, C):'Exp'---X--->seq(E_1, C) :-
        check(E:'E'),
        check(C:'C'),
        E:'E'---X--->E_1,
        check(E_1:'E').

seq(V, C):'Exp'---X--->seq(V, C_1) :-
        check(V:'V'),
        check(C:'C'),
        C:'C'---X--->C_1,
        check(C_1:'C').

seq(V, skip):'Exp'---U--->V :-
        check(V:'V'),
        check(U:'U').

