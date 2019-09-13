:-ensure_loaded('Data/Passable/ABS.pro').

:-ensure_loaded('Data/Value/ABS.pro').

declare('Passable'>'Value').

E:'Arg'---X--->E_1 :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

