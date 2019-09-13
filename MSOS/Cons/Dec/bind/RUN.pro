bind(I, E):'Dec'---X--->bind(I, E_1) :-
        check(I:'I'),
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

bind(I, BV):'Dec'---U--->map([I+>BV]) :-
        check(I:'I'),
        check(BV:'BV'),
        check(U:'U').

