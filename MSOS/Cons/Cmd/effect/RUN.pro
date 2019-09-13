effect(E):'Cmd'---X--->effect(E_1) :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

effect(V):'Cmd'---U--->skip :-
        check(V:'V'),
        check(U:'U').

