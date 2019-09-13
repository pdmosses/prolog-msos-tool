:-ensure_loaded('Cons/Cmd/RUN.pro').

:-ensure_loaded('Cons/Exp/RUN.pro').

:-ensure_loaded('Cons/Var/RUN.pro').

:-ensure_loaded('Cons/Arg/RUN.pro').

:-ensure_loaded('Data/Value/ABS.pro').

:-ensure_loaded('Data/Cell/ABS.pro').

:-ensure_loaded('Data/Passable/ABS.pro').

:-ensure_loaded('Data/Bindable/ABS.pro').

:-ensure_loaded('Data/Storable/ABS.pro').

:-ensure_loaded('Data/Env/ABS.pro').

:-ensure_loaded('Data/Store/ABS.pro').

:-ensure_loaded('ABS.pro').

declare('State'>'Cmd').

declare('State'>'Exp').

declare('State'>'Var').

declare('State'>'Arg').

declare('Final'>[skip]).

declare('Final'>'Value').

declare('Final'>'Cell').

declare('Final'>'Passable').

declare('Var'>'Cell').

declare('Arg'>'Passable').

declare('V':'Value').

declare('Value'>'Boolean').

declare('Value'>'Integer').

declare('BV':'Bindable').

declare('Bindable'>'Cell').

declare('PV':'Passable').

declare('Passable'>'Value').

declare('Passable'>tup('Value', 'Value')).

declare('SV':'Storable').

declare('Storable'>'Integer').

readable(env).

readable(store).

writable(store).

writable(out).

seq(C1, C2):'Cmd'---X--->seq(C1_1, C2) :-
        check(C1:'C'),
        check(C2:'C'),
        C1:'C'---X--->C1_1,
        check(C1_1:'C').

seq(skip, C2):'Cmd'---U--->C2 :-
        check(C2:'C'),
        check(U:'U').

cond_nz(E, C):'Cmd'---X--->cond_nz(E_1, C) :-
        check(E:'E'),
        check(C:'C'),
        E:'E'---X--->E_1,
        check(E_1:'E').

cond_nz(0, C):'Cmd'---U--->skip :-
        check(C:'C'),
        check(U:'U').

cond_nz(N, C):'Cmd'---U--->C :-
        check(N:'N'),
        check(C:'C'),
        check(U:'U'),
        eq(N\=0, true).

while_nz(E, C):'Cmd'---U--->cond_nz(E, seq(C, while_nz(E, C))) :-
        check(E:'E'),
        check(C:'C'),
        check(U:'U').

effect(E):'Cmd'---X--->effect(E_1) :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

effect(V):'Cmd'---U--->skip :-
        check(V:'V'),
        check(U:'U').

print(E):'Cmd'---X--->print(E_1) :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

print(V):'Cmd'---X_--->skip :-
        eq_label(X_, [out+=V|U]),
        check(V:'V'),
        check(U:'U').

VAR:'Exp'---X--->VAR_1 :-
        check(VAR:'VAR'),
        VAR:'VAR'---X--->VAR_1,
        check(VAR_1:'VAR').

CL:'Exp'---X_--->V :-
        eq_label(X_, [store=S, store+=S|U]),
        check(CL:'CL'),
        check(U:'U'),
        check(S:'S'),
        eq(lookup(CL, S), V),
        check(V:'V').

assign_seq(VAR, E):'Exp'---X--->assign_seq(VAR_1, E) :-
        check(VAR:'VAR'),
        check(E:'E'),
        VAR:'VAR'---X--->VAR_1,
        check(VAR_1:'VAR').

assign_seq(CL, E):'Exp'---X--->assign_seq(CL, E_1) :-
        check(CL:'CL'),
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

assign_seq(CL, SV):'Exp'---X_--->SV :-
        eq_label(X_, [store=S, store+=S_1|U]),
        check(CL:'CL'),
        check(SV:'SV'),
        check(U:'U'),
        check(S:'S'),
        eq(map([CL+>SV])/S, S_1),
        check(S_1:'S').

app(O, ARG):'Exp'---X--->app(O, ARG_1) :-
        check(O:'O'),
        check(ARG:'ARG'),
        ARG:'ARG'---X--->ARG_1,
        check(ARG_1:'ARG').

app(O, tup(V1, V2)):'Exp'---U--->V_1 :-
        check(O:'O'),
        check(V1:'V'),
        check(V2:'V'),
        check(U:'U'),
        eq(app_op(O, V1, V2), V_1),
        check(V_1:'V').

app(O, V):'Exp'---U--->V_1 :-
        check(O:'O'),
        check(V:'V'),
        check(U:'U'),
        eq(app_op(O, V), V_1),
        check(V_1:'V').

I:'Var'---X_--->CL :-
        eq_label(X_, [env=ENV|U]),
        check(I:'I'),
        check(U:'U'),
        check(ENV:'ENV'),
        eq(lookup(I, ENV), CL),
        check(CL:'CL').

E:'Arg'---X--->E_1 :-
        check(E:'E'),
        E:'E'---X--->E_1,
        check(E_1:'E').

tup_seq(E1, E2):'Arg'---X--->tup_seq(E1_1, E2) :-
        check(E1:'E'),
        check(E2:'E'),
        E1:'E'---X--->E1_1,
        check(E1_1:'E').

tup_seq(V1, E2):'Arg'---X--->tup_seq(V1, E2_1) :-
        check(V1:'V'),
        check(E2:'E'),
        E2:'E'---X--->E2_1,
        check(E2_1:'E').

tup_seq(V1, V2):'Arg'---U--->tup(V1, V2) :-
        check(V1:'V'),
        check(V2:'V'),
        check(U:'U').

