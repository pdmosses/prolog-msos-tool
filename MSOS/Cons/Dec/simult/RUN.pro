:-ensure_loaded('ABS.pro').

simult(D1, D2):'Dec'---X--->simult(D1_1, D2) :-
        check(D1:'D'),
        check(D2:'D'),
        D1:'D'---X--->D1_1,
        check(D1_1:'D').

simult(D1, D2):'Dec'---X--->simult(D1, D2_1) :-
        check(D1:'D'),
        check(D2:'D'),
        D2:'D'---X--->D2_1,
        check(D2_1:'D').

simult(ENV1, ENV2):'Dec'---U--->ENV :-
        check(ENV1:'ENV'),
        check(ENV2:'ENV'),
        check(U:'U'),
        eq(ENV1+ENV2, ENV),
        check(ENV:'ENV').

