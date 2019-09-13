:-ensure_loaded('Cons/Sys/RUN.pro').

:-ensure_loaded('Cons/Abs/RUN.pro').

:-ensure_loaded('ABS.pro').

declare('Final'>[skip]).

declare('Sys'>[skip]).

writable(starting).

C:'Sys'---X_--->conc(C_1, effect(app(ABS, tup(null)))) :-
        eq_label(X_, [starting+=null|X]),
        check(C:'C'),
        C:'C'---[starting+=ABS|X]--->C_1,
        check(C_1:'C'),
        check(ABS:'ABS').

C:'Sys'---X_--->C_1 :-
        eq_label(X_, [starting+=null|X]),
        check(C:'C'),
        C:'C'---[starting+=null|X]--->C_1,
        check(C_1:'C').

conc(skip, SYS):'Sys'---U--->SYS :-
        check(SYS:'SYS'),
        check(U:'U').

conc(SYS, skip):'Sys'---U--->SYS :-
        check(SYS:'SYS'),
        check(U:'U').

