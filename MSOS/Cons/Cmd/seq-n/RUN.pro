seq(Cp):'Cmd'---X--->seq(C_1p) :-
        check(Cp: +'C'),
        seq_concat(C1, C2s, Cp),
        check(C1:'C'),
        check(C2s: *('C')),
        C1:'C'---X--->C1_1,
        check(C1_1:'C'),
        seq_concat(C1_1, C2s, C_1p),
        check(C_1p: +'C').

seq(Cp):'Cmd'---U--->seq(C2p) :-
        check(Cp: +'C'),
        check(U:'U'),
        seq_concat(skip, C2p, Cp),
        check(C2p: +'C').

seq(skip):'Cmd'---U--->skip :-
        check(U:'U').

