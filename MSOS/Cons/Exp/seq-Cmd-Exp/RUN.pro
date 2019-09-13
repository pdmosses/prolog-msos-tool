seq(C, E):'Exp'---X--->seq(C_1, E) :-
        check(C:'C'),
        check(E:'E'),
        C:'C'---X--->C_1,
        check(C_1:'C').

seq(skip, E):'Exp'---U--->E :-
        check(E:'E'),
        check(U:'U').

