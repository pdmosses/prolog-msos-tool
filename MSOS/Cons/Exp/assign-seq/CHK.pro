:-ensure_loaded('Data/CellType/ABS.pro').

:-ensure_loaded('Data/StorableType/ABS.pro').

declare('CellType'>ref('StorableType')).

assign_seq(VAR, E):'Exp'===U===>VT :-
        check(VAR:'VAR'),
        check(E:'E'),
        check(U:'U'),
        VAR:'VAR'===U===>ref(VT),
        check(VT:'VT'),
        E:'E'===U===>VT.

