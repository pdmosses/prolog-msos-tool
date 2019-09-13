:-ensure_loaded('Data/Env/ABS.pro').

readable(env).

local(D1, D2):'Dec'---X--->local(D1_1, D2) :-
        check(D1:'D'),
        check(D2:'D'),
        D1:'D'---X--->D1_1,
        check(D1_1:'D').

local(ENV1, D2):'Dec'---X_--->local(ENV1, D2_1) :-
        eq_label(X_, [env=ENV0|X]),
        check(ENV1:'ENV'),
        check(D2:'D'),
        check(ENV0:'ENV'),
        eq(ENV1/ENV0, ENV_1),
        check(ENV_1:'ENV'),
        D2:'D'---[env=ENV_1|X]--->D2_1,
        check(D2_1:'D').

local(ENV1, ENV2):'Dec'---U--->ENV2 :-
        check(ENV1:'ENV'),
        check(ENV2:'ENV'),
        check(U:'U').

