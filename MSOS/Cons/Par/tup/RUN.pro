:-ensure_loaded('Cons/Dec/app/RUN.pro').

:-ensure_loaded('Cons/Dec/simult/RUN.pro').

:-ensure_loaded('ABS.pro').

app(tup(PARp), tup(BVp)):'Dec'---U--->simult(app(PAR, BV), app(tup(PARs), tup(BVs))) :-
        check(PARp: +'PAR'),
        check(BVp: +'BV'),
        check(U:'U'),
        seq_concat(PAR, PARs, PARp),
        check(PAR:'PAR'),
        check(PARs: *('PAR')),
        seq_concat(BV, BVs, BVp),
        check(BV:'BV'),
        check(BVs: *('BV')).

app(tup(null), tup(null)):'Dec'---U--->ENV :-
        check(U:'U'),
        eq(void, ENV),
        check(ENV:'ENV').

