:-ensure_loaded('ABS.pro').

conc(SYS1, SYS2):'Sys'---X--->conc(SYS1_1, SYS2) :-
        check(SYS1:'SYS'),
        check(SYS2:'SYS'),
        SYS1:'SYS'---X--->SYS1_1,
        check(SYS1_1:'SYS').

conc(SYS1, SYS2):'Sys'---X--->conc(SYS1, SYS2_1) :-
        check(SYS1:'SYS'),
        check(SYS2:'SYS'),
        SYS2:'SYS'---X--->SYS2_1,
        check(SYS2_1:'SYS').

