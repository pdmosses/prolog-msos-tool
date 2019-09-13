:-ensure_loaded('Data/Channels/ABS.pro').

:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('Data/Channel/ABS.pro').

:-ensure_loaded('ABS.pro').

readable(chans).

writable(chans).

declare('Value'>'Channel').

alloc_chan:'Exp'---X_--->CHAN :-
        eq_label(X_, [chans=CHANS, chans+=CHANS_1|U]),
        check(U:'U'),
        check(CHANS:'CHANS'),
        eq(new_chan(CHANS), CHAN),
        check(CHAN:'CHAN'),
        eq(CHANS+set([CHAN]), CHANS_1),
        check(CHANS_1:'CHANS').

