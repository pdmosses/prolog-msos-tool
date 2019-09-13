:-ensure_loaded('Data/Value/ABS.pro').

declare('Value'>tup(*('Value'))).

tup_seq(Ep):'Exp'---X--->tup_seq(E_1p) :-
        check(Ep: +'E'),
        seq_concat(V1s, E2p, Ep),
        check(V1s: *('V')),
        check(E2p: +'E'),
        seq_concat(E, E3s, E2p),
        check(E:'E'),
        check(E3s: *('E')),
        E:'E'---X--->E_1,
        check(E_1:'E'),
        seq_concat(E_1, E3s, E2_1p),
        check(E2_1p: +'E'),
        seq_concat(V1s, E2_1p, E_1p),
        check(E_1p: +'E').

tup_seq(Vs):'Exp'---U--->tup(Vs) :-
        check(Vs: *('V')),
        check(U:'U').

