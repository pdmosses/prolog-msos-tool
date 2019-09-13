:-ensure_loaded('Data/Store/ABS.pro').

readable(store).

writable(store).

assigned(VAR):'Exp'---X--->assigned(VAR_1) :-
        check(VAR:'VAR'),
        VAR:'VAR'---X--->VAR_1,
        check(VAR_1:'VAR').

assigned(CL):'Exp'---X_--->SV :-
        eq_label(X_, [store=S, store+=S|U]),
        check(CL:'CL'),
        check(U:'U'),
        check(S:'S'),
        eq(lookup(CL, S), SV),
        check(SV:'SV').

