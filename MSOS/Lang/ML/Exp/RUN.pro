:-ensure_loaded('Cons/Prog/RUN.pro').

:-ensure_loaded('Cons/Prog/Exp/RUN.pro').

:-ensure_loaded('Cons/Exp/RUN.pro').

:-ensure_loaded('Cons/Exp/Boolean/RUN.pro').

:-ensure_loaded('Cons/Exp/Integer/RUN.pro').

:-ensure_loaded('Cons/Exp/Character/RUN.pro').

:-ensure_loaded('Cons/Exp/String/RUN.pro').

:-ensure_loaded('Cons/Exp/Id/RUN.pro').

:-ensure_loaded('Cons/Exp/cond/RUN.pro').

:-ensure_loaded('Cons/Exp/app-Op/RUN.pro').

:-ensure_loaded('Cons/Exp/app-Id/RUN.pro').

:-ensure_loaded('Cons/Exp/tup/RUN.pro').

:-ensure_loaded('Cons/Exp/tup-seq/RUN.pro').

:-ensure_loaded('Cons/Arg/RUN.pro').

:-ensure_loaded('Cons/Arg/Exp/RUN.pro').

:-ensure_loaded('Cons/Op/RUN.pro').

:-ensure_loaded('Cons/Id/RUN.pro').

:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('Data/Bindable/ABS.pro').

:-ensure_loaded('Data/Passable/ABS.pro').

:-ensure_loaded('ABS.pro').

declare('Value'>'List'('Value')).

declare('Bindable'>'Value').

declare('Bindable'>'Op').

declare('Op'>[cons]).

declare('Op'>[=]).

declare('Op'>[abs]).

declare('Op'>[+]).

declare('Op'>[-]).

declare('Op'>[*]).

declare('Op'>[div]).

declare('Op'>[mod]).

declare('Op'>[<]).

declare('Op'>[>]).

declare('Op'>[=<]).

declare('Op'>[>=]).

declare('Op'>[nth]).

declare('Passable'>'Value').

eq(init_env, map([id(true)+>true, id(false)+>false, id(nil)+>list([]), id(::)+>cons, id(=)+> (=), id(~)+> -, id(abs)+>abs, id(+)+> +, id(-)+> -, id(*)+> *, id(div)+>div, id(mod)+>mod, id(<)+> (<), id(>)+> (>), id(<=)+> (=<), id(>=)+> (>=)])).

