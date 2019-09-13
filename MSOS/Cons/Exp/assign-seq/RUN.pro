:-ensure_loaded('Data/Store/ABS.pro').

readable(store).

writable(store).

assign_seq(VAR, E):'Exp'---X--->assign_seq(VAR_1, E) :-
        check(VAR:'VAR'),
        check(E:'E'),
        VAR:'VAR'---X--->VAR_1,
        check(VAR_1:'VAR').

assign_seq(CL, E):'Exp'---X--->assign_seq(CL, E_1) :-
        check(CL:'CL'),
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

assign_seq(CL, SV):'Exp'---X_--->SV :-
        eq_label(X_, [store=S, store+=S_1|U]),
        check(CL:'CL'),
        check(SV:'SV'),
        check(U:'U'),
        check(S:'S'),
        eq(lookup(CL, S), _),
        eq(map([CL+>SV])/S, S_1),
        check(S_1:'S').

