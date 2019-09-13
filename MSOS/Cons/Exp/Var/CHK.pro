:-ensure_loaded('Data/CellType/ABS.pro').

:-ensure_loaded('Data/StorableType/ABS.pro').

declare('CellType'>ref('StorableType')).

VAR:'Exp'===U===>VT :-
        check(VAR:'VAR'),
        check(U:'U'),
        VAR:'VAR'===U===>ref(VT),
        check(VT:'VT').

