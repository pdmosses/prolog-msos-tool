:-ensure_loaded('Cons/Cmd/ABS.pro').

:-ensure_loaded('Cons/Exp/ABS.pro').

declare('Cmd'>cond_nz('Exp', 'Cmd')).

