:-ensure_loaded('Cons/Op/CHK.pro').

:-ensure_loaded('Data/FuncType/ABS.pro').

:-ensure_loaded('Data/PassableType/ABS.pro').

:-ensure_loaded('Data/ValueType/ABS.pro').

declare('State'>'Op').

declare('Final'>'FuncType').

declare('FuncType'>func('PassableType', 'ValueType')).

