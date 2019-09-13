:-ensure_loaded('Data/Store/ABS.pro').

readable(store).

writable(store).

alloc(E):'Var'---X--->alloc(E_1) :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

alloc(SV):'Var'---X_--->CL :-
        eq_label(X_, [store=S, store+=S_1|U]),
        check(SV:'SV'),
        check(U:'U'),
        check(S:'S'),
        eq(new_cell(S), CL),
        check(CL:'CL'),
        eq(map([CL+>SV])/S, S_1),
        check(S_1:'S').

