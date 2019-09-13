:-ensure_loaded('ABS.pro').

D:'Prog'---X--->D_1 :-
        check(D:'D'),
        D:'D'---X--->D_1,
        check(D_1:'D').

