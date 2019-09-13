:-ensure_loaded('Data/Bindable/ABS.pro').

:-ensure_loaded('Data/CellType/ABS.pro').

:-ensure_loaded('Data/StorableType/ABS.pro').

:-ensure_loaded('Data/Env/ABS.pro').

:-ensure_loaded('ABS.pro').

declare('Bindable'>'CellType').

declare('CellType'>ref('StorableType')).

readable(env).

I:'Var'===X_===>ref(SVT) :-
        eq_label(X_, [env=ENV|U]),
        check(I:'I'),
        check(U:'U'),
        check(ENV:'ENV'),
        eq(lookup(I, ENV), ref(SVT)),
        check(SVT:'SVT').

