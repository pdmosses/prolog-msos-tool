:-ensure_loaded('Data/Store/ABS.pro').

readable(store).

writable(store).

VAR:'Exp'---X--->VAR_1 :-
        check(VAR:'VAR'),
        VAR:'VAR'---X--->VAR_1,
        check(VAR_1:'VAR').

CL:'Exp'---X_--->V :-
        eq_label(X_, [store=S, store+=S|U]),
        check(CL:'CL'),
        check(U:'U'),
        check(S:'S'),
        eq(lookup(CL, S), V),
        check(V:'V').

