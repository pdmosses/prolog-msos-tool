:-ensure_loaded('Data/Event/ABS.pro').

:-ensure_loaded('Data/Channel/ABS.pro').

:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('ABS.pro').

writable(event).

declare('Event'>sending('Channel', 'Value')).

declare('Event'>receiving('Channel', 'Value')).

conc(SYS1, SYS2):'Sys'---X_--->conc(SYS1_1, SYS2_1) :-
        eq_label(X_, [event+=null|U]),
        check(SYS1:'SYS'),
        check(SYS2:'SYS'),
        check(U:'U'),
        SYS1:'SYS'---[event+=sending(CHAN, V)|U]--->SYS1_1,
        check(SYS1_1:'SYS'),
        SYS2:'SYS'---[event+=receiving(CHAN, V)|U]--->SYS2_1,
        check(SYS2_1:'SYS').

conc(SYS1, SYS2):'Sys'---X_--->conc(SYS1_1, SYS2_1) :-
        eq_label(X_, [event+=null|U]),
        check(SYS1:'SYS'),
        check(SYS2:'SYS'),
        check(U:'U'),
        SYS2:'SYS'---[event+=sending(CHAN, V)|U]--->SYS2_1,
        check(SYS2_1:'SYS'),
        SYS1:'SYS'---[event+=receiving(CHAN, V)|U]--->SYS1_1,
        check(SYS1_1:'SYS').

