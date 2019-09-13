:-ensure_loaded('Cons/Dec/RUN.pro').

:-ensure_loaded('Cons/Dec/bind/RUN.pro').

:-ensure_loaded('Cons/Dec/simult/RUN.pro').

:-ensure_loaded('Cons/Dec/simult-seq/RUN.pro').

:-ensure_loaded('Cons/Exp/close/RUN.pro').

:-ensure_loaded('Cons/Abs/closure/RUN.pro').

:-ensure_loaded('ABS.pro').

declare('State'>reclose('Dec', 'Dec')).

declare('Dec'>reclose('Dec', 'Dec')).

rec(D):'Dec'---U--->reclose(rec(D), D) :-
        check(D:'D'),
        check(U:'U').

reclose(rec(D), bind(I, close(ABS))):'Dec'---U--->bind(I, close(closure(rec(D), ABS))) :-
        check(D:'D'),
        check(I:'I'),
        check(ABS:'ABS'),
        check(U:'U').

reclose(rec(D), simult_seq(D1, D2)):'Dec'---U--->simult_seq(reclose(rec(D), D1), reclose(rec(D), D2)) :-
        check(D:'D'),
        check(D1:'D'),
        check(D2:'D'),
        check(U:'U').

reclose(rec(D), simult(D1, D2)):'Dec'---U--->simult(reclose(rec(D), D1), reclose(rec(D), D2)) :-
        check(D:'D'),
        check(D1:'D'),
        check(D2:'D'),
        check(U:'U').

