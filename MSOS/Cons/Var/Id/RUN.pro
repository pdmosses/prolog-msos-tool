:-ensure_loaded('Data/Bindable/ABS.pro').

:-ensure_loaded('Data/Cell/ABS.pro').

:-ensure_loaded('Data/Env/ABS.pro').

declare('Bindable'>'Cell').

readable(env).

I:'Var'---X_--->CL :-
        eq_label(X_, [env=ENV|U]),
        check(I:'I'),
        check(U:'U'),
        check(ENV:'ENV'),
        eq(lookup(I, ENV), CL),
        check(CL:'CL').

