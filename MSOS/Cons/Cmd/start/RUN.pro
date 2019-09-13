:-ensure_loaded('Cons/Abs/RUN.pro').

:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('ABS.pro').

writable(starting).

declare('Value'>'Abs').

start(E):'Cmd'---X--->start(E_1) :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

start(ABS):'Cmd'---X_--->skip :-
        eq_label(X_, [starting+=ABS|U]),
        check(ABS:'ABS'),
        check(U:'U').

