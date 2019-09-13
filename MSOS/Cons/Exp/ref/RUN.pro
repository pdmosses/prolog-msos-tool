:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('Data/Cell/ABS.pro').

declare('Value'>ref('Cell')).

ref(VAR):'Exp'---X--->ref(VAR_1) :-
        check(VAR:'VAR'),
        VAR:'VAR'---X--->VAR_1,
        check(VAR_1:'VAR').

