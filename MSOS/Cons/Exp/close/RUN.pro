:-ensure_loaded('Cons/Abs/closure/RUN.pro').

:-ensure_loaded('Data/Env/ABS.pro').

:-ensure_loaded('ABS.pro').

readable(env).

close(ABS):'Exp'---X_--->closure(ENV, ABS) :-
        eq_label(X_, [env=ENV|U]),
        check(ABS:'ABS'),
        check(U:'U'),
        check(ENV:'ENV').

