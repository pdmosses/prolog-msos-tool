:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('Data/Cell/ABS.pro').

declare('Value'>ref('Cell')).

deref(E):'Var'---X--->deref(E_1) :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

deref(ref(CL)):'Var'---U--->CL :-
        check(CL:'CL'),
        check(U:'U').

