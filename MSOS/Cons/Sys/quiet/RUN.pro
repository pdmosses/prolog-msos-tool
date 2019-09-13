:-ensure_loaded('Data/Event/ABS.pro').

:-ensure_loaded('ABS.pro').

writable(event).

quiet(SYS):'Sys'---X_--->quiet(SYS_1) :-
        eq_label(X_, [event+=null|X]),
        check(SYS:'SYS'),
        SYS:'SYS'---[event+=null|X]--->SYS_1,
        check(SYS_1:'SYS').

quiet(skip):'Sys'---U--->skip :-
        check(U:'U').

