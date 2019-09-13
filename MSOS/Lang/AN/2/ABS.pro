:-ensure_loaded('Cons/Prog/ABS.pro').

:-ensure_loaded('Cons/Term/ABS.pro').

:-ensure_loaded('Cons/Id/ABS.pro').

declare('Prog'>'Term').

declare('Term'>inf('Term', 'Id', 'Term')).

declare('Term'>pre('Term', 'Term')).

declare('Term'>group(+'Term')).

declare('Term'>'Id').

declare('Id'>'Atom').

