:-ensure_loaded('Data/Value/ABS.pro').

writable(out).

print(E):'Cmd'---X--->print(E_1) :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

print(V):'Cmd'---X_--->skip :-
        eq_label(X_, [out+=V|U]),
        check(V:'V'),
        check(U:'U').

