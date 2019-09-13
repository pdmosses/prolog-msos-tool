:-ensure_loaded('Data/Event/ABS.pro').

:-ensure_loaded('Data/Channel/ABS.pro').

:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('ABS.pro').

writable(event).

declare('Event'>receiving('Channel', 'Value')).

declare('Value'>'Channel').

recv_chan(E):'Exp'---X--->recv_chan(E_1) :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

recv_chan(CHAN):'Exp'---X_--->V :-
        eq_label(X_, [event+=receiving(CHAN, V)|U]),
        check(CHAN:'CHAN'),
        check(U:'U'),
        check(V:'V').

