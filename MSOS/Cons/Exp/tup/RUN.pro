:-ensure_loaded('Data/Value/ABS.pro').

declare('Value'>tup(*('Value'))).

tup(Ep):'Exp'---X--->tup(E_1p) :-
        check(Ep: +'E'),
        seq_concat(E1s, E2p, Ep),
        check(E1s: *('E')),
        check(E2p: +'E'),
        seq_concat(E, E3s, E2p),
        check(E:'E'),
        check(E3s: *('E')),
        E:'E'---X--->E_1,
        check(E_1:'E'),
        seq_concat(E_1, E3s, E2_1p),
        check(E2_1p: +'E'),
        seq_concat(E1s, E2_1p, E_1p),
        check(E_1p: +'E').

