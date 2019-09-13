:-ensure_loaded('Data/Passable/ABS.pro').

:-ensure_loaded('Data/Value/ABS.pro').

declare('Passable'>tup('Value', 'Value')).

tup_seq(E1, E2):'Arg'---X--->tup_seq(E1_1, E2) :-
        check(E1:'E'),
        check(E2:'E'),
        E1:'E'---X--->E1_1,
        check(E1_1:'E').

tup_seq(V1, E2):'Arg'---X--->tup_seq(V1, E2_1) :-
        check(V1:'V'),
        check(E2:'E'),
        E2:'E'---X--->E2_1,
        check(E2_1:'E').

tup_seq(V1, V2):'Arg'---U--->tup(V1, V2) :-
        check(V1:'V'),
        check(V2:'V'),
        check(U:'U').

