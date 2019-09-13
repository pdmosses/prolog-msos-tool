:-ensure_loaded('Data/Env/ABS.pro').

readable(env).

local(D, E):'Exp'---X--->local(D_1, E) :-
        check(D:'D'),
        check(E:'E'),
        D:'D'---X--->D_1,
        check(D_1:'D').

local(ENV, E):'Exp'---X_--->local(ENV, E_1) :-
        eq_label(X_, [env=ENV0|X]),
        check(ENV:'ENV'),
        check(E:'E'),
        check(ENV0:'ENV'),
        eq(ENV/ENV0, ENV_1),
        check(ENV_1:'ENV'),
        E:'E'---[env=ENV_1|X]--->E_1,
        check(E_1:'E').

local(ENV, V):'Exp'---U--->V :-
        check(ENV:'ENV'),
        check(V:'V'),
        check(U:'U').

