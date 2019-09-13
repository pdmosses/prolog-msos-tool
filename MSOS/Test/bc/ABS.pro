:-ensure_loaded('Cons/Cmd/ABS.pro').

:-ensure_loaded('Cons/Exp/ABS.pro').

:-ensure_loaded('Cons/Var/ABS.pro').

:-ensure_loaded('Cons/Op/ABS.pro').

:-ensure_loaded('Cons/Arg/ABS.pro').

:-ensure_loaded('Cons/Id/ABS.pro').

declare('C':'Cmd').

declare('Cmd'>[skip]).

declare('Cmd'>seq('Cmd', 'Cmd')).

declare('Cmd'>cond_nz('Exp', 'Cmd')).

declare('Cmd'>while_nz('Exp', 'Cmd')).

declare('Cmd'>effect('Exp')).

declare('Cmd'>print('Exp')).

declare('E':'Exp').

declare('Exp'>'Boolean').

declare('Exp'>'Integer').

declare('Exp'>'Var').

declare('Exp'>assign_seq('Var', 'Exp')).

declare('Exp'>app('Op', 'Arg')).

declare('VAR':'Var').

declare('Var'>'Id').

declare('O':'Op').

declare('Op'>[+]).

declare('Op'>[-]).

declare('Op'>[*]).

declare('Op'>[div]).

declare('Op'>[mod]).

declare('Op'>[ord]).

declare('Op'>[<]).

declare('Op'>[=<]).

declare('Op'>[>]).

declare('Op'>[>=]).

declare('Op'>[=]).

declare('Op'>[\=]).

declare('ARG':'Arg').

declare('Arg'>'Exp').

declare('Arg'>tup_seq('Exp', 'Exp')).

declare('I':'Id').

declare('Id'>id('Atom')).

