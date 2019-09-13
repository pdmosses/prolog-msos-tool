:-ensure_loaded('Cons/Cmd/CHK.pro').

:-ensure_loaded('Cons/Exp/CHK.pro').

:-ensure_loaded('Cons/Var/CHK.pro').

:-ensure_loaded('Cons/Op/CHK.pro').

:-ensure_loaded('Cons/Arg/CHK.pro').

:-ensure_loaded('Data/ValueType/ABS.pro').

:-ensure_loaded('Data/CellType/ABS.pro').

:-ensure_loaded('Data/FuncType/ABS.pro').

:-ensure_loaded('Data/PassableType/ABS.pro').

:-ensure_loaded('Data/StorableType/ABS.pro').

:-ensure_loaded('Data/Bindable/ABS.pro').

:-ensure_loaded('Data/Env/ABS.pro').

:-ensure_loaded('ABS.pro').

declare('State'>'Cmd').

declare('State'>'Exp').

declare('State'>'Var').

declare('State'>'Op').

declare('State'>'Arg').

declare('Final'>[void]).

declare('Final'>'ValueType').

declare('Final'>'CellType').

declare('Final'>'FuncType').

declare('Final'>'PassableType').

declare('VT':'ValueType').

declare('ValueType'>[bool]).

declare('ValueType'>[int]).

declare('CLT':'CellType').

declare('CellType'>ref('StorableType')).

declare('FNT':'FuncType').

declare('FuncType'>func('PassableType', 'ValueType')).

declare('PVT':'PassableType').

declare('PassableType'>'ValueType').

declare('PassableType'>tup('ValueType', 'ValueType')).

declare('BV':'Bindable').

declare('Bindable'>'CellType').

declare('SVT':'StorableType').

declare('StorableType'>[int]).

readable(env).

skip:'Cmd'===U===>void :-
        check(U:'U').

seq(C1, C2):'Cmd'===U===>void :-
        check(C1:'C'),
        check(C2:'C'),
        check(U:'U'),
        C1:'C'===U===>void,
        C2:'C'===U===>void.

cond_nz(E, C):'Cmd'===U===>void :-
        check(E:'E'),
        check(C:'C'),
        check(U:'U'),
        E:'E'===U===>int,
        C:'C'===U===>void.

while_nz(E, C):'Cmd'===U===>void :-
        check(E:'E'),
        check(C:'C'),
        check(U:'U'),
        E:'E'===U===>int,
        C:'C'===U===>void.

effect(E):'Cmd'===U===>void :-
        check(E:'E'),
        check(U:'U'),
        E:'E'===U===>VT,
        check(VT:'VT').

print(E):'Cmd'===U===>void :-
        check(E:'E'),
        check(U:'U'),
        E:'E'===U===>VT,
        check(VT:'VT').

B:'Exp'===U===>bool :-
        check(B:'B'),
        check(U:'U').

N:'Exp'===U===>int :-
        check(N:'N'),
        check(U:'U').

VAR:'Exp'===U===>VT :-
        check(VAR:'VAR'),
        check(U:'U'),
        VAR:'VAR'===U===>ref(VT),
        check(VT:'VT').

assign_seq(VAR, E):'Exp'===U===>VT :-
        check(VAR:'VAR'),
        check(E:'E'),
        check(U:'U'),
        VAR:'VAR'===U===>ref(VT),
        check(VT:'VT'),
        E:'E'===U===>VT.

app(O, ARG):'Exp'===U===>VT :-
        check(O:'O'),
        check(ARG:'ARG'),
        check(U:'U'),
        O:'O'===U===>func(PVT, VT),
        check(PVT:'PVT'),
        check(VT:'VT'),
        ARG:'ARG'===U===>PVT.

+ :'Op'===U===>func(tup(int, int), int) :-
        check(U:'U').

- :'Op'===U===>func(tup(int, int), int) :-
        check(U:'U').

* :'Op'===U===>func(tup(int, int), int) :-
        check(U:'U').

div:'Op'===U===>func(tup(int, int), int) :-
        check(U:'U').

mod:'Op'===U===>func(tup(int, int), int) :-
        check(U:'U').

ord:'Op'===U===>func(bool, int) :-
        check(U:'U').

(<):'Op'===U===>func(tup(int, int), bool) :-
        check(U:'U').

(=<):'Op'===U===>func(tup(int, int), bool) :-
        check(U:'U').

(>):'Op'===U===>func(tup(int, int), bool) :-
        check(U:'U').

(>=):'Op'===U===>func(tup(int, int), bool) :-
        check(U:'U').

(=):'Op'===U===>func(tup(int, int), bool) :-
        check(U:'U').

(\=):'Op'===U===>func(tup(int, int), bool) :-
        check(U:'U').

I:'Var'===X_===>ref(SVT) :-
        eq_label(X_, [env=ENV|U]),
        check(I:'I'),
        check(U:'U'),
        check(ENV:'ENV'),
        eq(lookup(I, ENV), ref(SVT)),
        check(SVT:'SVT').

E:'Arg'===U===>VT :-
        check(E:'E'),
        check(U:'U'),
        E:'E'===U===>VT,
        check(VT:'VT').

tup_seq(E1, E2):'Arg'===U===>tup(VT1, VT2) :-
        check(E1:'E'),
        check(E2:'E'),
        check(U:'U'),
        E1:'E'===U===>VT1,
        check(VT1:'VT'),
        E2:'E'===U===>VT2,
        check(VT2:'VT').

