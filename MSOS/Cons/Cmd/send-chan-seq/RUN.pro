:-ensure_loaded('Data/Event/ABS.pro').

:-ensure_loaded('Data/Channel/ABS.pro').

:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('ABS.pro').

writable(event).

declare('Event'>sending('Channel', 'Value')).

declare('Value'>'Channel').

send_chan_seq(E1, E2):'Cmd'---X--->send_chan_seq(E1_1, E2) :-
        check(E1:'E'),
        check(E2:'E'),
        E1:'E'---X--->E1_1,
        check(E1_1:'E').

send_chan_seq(CHAN, E2):'Cmd'---X--->send_chan_seq(CHAN, E2_1) :-
        check(CHAN:'CHAN'),
        check(E2:'E'),
        E2:'E'---X--->E2_1,
        check(E2_1:'E').

send_chan_seq(CHAN, V):'Cmd'---X_--->skip :-
        eq_label(X_, [event+=sending(CHAN, V)|U]),
        check(CHAN:'CHAN'),
        check(V:'V'),
        check(U:'U').

