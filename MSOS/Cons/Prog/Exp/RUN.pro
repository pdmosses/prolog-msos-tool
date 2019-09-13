:-ensure_loaded('ABS.pro').

E:'Prog'---X--->E_1 :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

