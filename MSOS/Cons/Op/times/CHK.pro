:-ensure_loaded('Data/Passable/ABS.pro').

:-ensure_loaded('Data/ValueType/ABS.pro').

declare('Passable'>tup('ValueType', 'ValueType')).

declare('ValueType'>[int]).

* :'Op'===U===>func(tup(int, int), int) :-
        check(U:'U').

