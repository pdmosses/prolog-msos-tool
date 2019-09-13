:-ensure_loaded('Cons/Id/RUN.pro').

:-ensure_loaded('Data/Bindable/ABS.pro').

:-ensure_loaded('Data/Env/ABS.pro').

:-ensure_loaded('ABS.pro').

declare('State'>'Id').

declare('Final'>'Bindable').

declare('Id'>'Bindable').

readable(env).

I:'Id'---X_--->BV :-
        eq_label(X_, [env=ENV|U]),
        check(I:'I'),
        check(U:'U'),
        check(ENV:'ENV'),
        eq(lookup(I, ENV), BV),
        check(BV:'BV').

I:'Id'---X_--->BV :-
        eq_label(X_, [env=ENV|U]),
        check(I:'I'),
        check(U:'U'),
        \+eq(lookup(I, ENV), _),
        eq(init_env, ENV_1),
        check(ENV_1:'ENV'),
        eq(lookup(I, ENV_1), BV),
        check(BV:'BV').

