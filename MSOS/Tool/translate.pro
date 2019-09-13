% translate.pro

/* Translation from parsed MSOS specifications to Prolog programs
*/

msdf2clauses(A, Ms, Ps) :-
	items2imports(A, Ms, Ps1),
	list_to_set(Ps1, Ps2),
	items2clauses(A, Ms, Ps3),
	append(Ps2, Ps3, Ps).

items2imports(A, [M|Ms], Ps) :- 
	item2imports(A, M, Ps1), 
	items2imports(A, Ms, Ps2), 
	append(Ps1, Ps2, Ps).
items2imports('ABS', [], []).
items2imports('CHK', [], [:- ensure_loaded('ABS.pro')]).
items2imports('RUN', [], [:- ensure_loaded('ABS.pro')]).

items2clauses(A, [M|Ms], Ps) :- 
	item2clauses(A, M, Ps1), 
	items2clauses(A, Ms, Ps2), 
	append(Ps1, Ps2, Ps).
items2clauses(_, [], []).

/* Declarations:
*/
item2imports(_, mvartype(_,_), 
	     []).
item2imports(_, mtype(_), 
	     []).
item2imports(A, mtypeincl(mvartype(_,MT2),MSTs), 
	     Ps) :-
	item2imports(A, mtypeincl(mtype(MT2),MSTs), Ps).
item2imports(A, mtypeincl(mtype(MT),[MST1,MST2|MSTs]), 
	     Ps) :-
	item2imports(A, mtypeincl(mtype(MT),[MST1]), Ps1), 
	item2imports(A, mtypeincl(mtype(MT),[MST2|MSTs]), Ps2),
	append(Ps1, Ps2, Ps).
item2imports(A, mtypeincl(mtype(MT),[MST]), 
	     Ps) :- 
	type2imports(A, MT, Ps1),
	subtype2imports(A, MST, Ps2),
	append(Ps1, Ps2, Ps).
% Ignoring selectors for now
item2imports(A, mtypeeq(mvartype(_,MT2),MT3), 
	     Ps) :-
 	item2imports(A, mtypeeq(mtype(MT2),MT3), Ps).
item2imports(A, mtypeeq(mtype('Label'),mlabeltype(MOTs)), 
	     Ps) :-
	labelfields2imports(A, MOTs, Ps).
item2imports(A, mtypeeq(_,MT2), 
	     Ps) :- 
	type2imports(A, MT2, Ps).

/* Rules:
   Operations in terms are generally restricted to constructors,
   except when the application is the left side of an equation.
*/
item2imports(_, mrule(_,_), 
	     []).
item2imports(_, mpredapp(eq, _, _),
	     []).

/* Imports
*/
item2imports(A, mimports([M|Ms]),
	     [:- ensure_loaded(MA)|Ps]) :-
	add_defaults(M, A, MA),
	item2imports(A, mimports(Ms), Ps).
item2imports(_, mimports([]), []).

/* Untranslated
*/

item2imports(_, AT, 
	     [AT]) :- atomic(AT).
item2imports(_, M, 
	     [msos(M)]).

/* Types and subtypes
*/
type2imports(A, mtupletype([MT]), 
	     Ps) :- 
	type2imports(A, MT,Ps).
type2imports(A, mtupletype([MT|MTs]), 
	     Ps) :- 
	type2imports(A, MT,Ps1), 
	type2imports(A, mtupletype(MTs), Ps2),
	append(Ps1, Ps2, Ps).
type2imports(A, mtypeapp(mtupletype(MTs),_MTO), 
	     Ps) :- 
	type2imports(A, mtupletype(MTs),Ps).
type2imports(A, mtypeapp(MT,_MTO), 
	     Ps) :- 
	type2imports(A, MT,Ps).
type2imports(A, MT, Ps) :- atom2imports(A, MT, Ps).

subtype2imports(A, mtypeapp(mtupletype(MTs),_MTO), 
	     Ps) :- 
	argtypes2imports(A, MTs,Ps).
subtype2imports(A, mtypeapp(MT,_MTO), 
	     Ps) :- 
	subtype2imports(A, MT,Ps).
subtype2imports(_A, mconsdec(_MOI,[]), 
	     []).
subtype2imports(A, mconsdec(_MOI,MATs), 
	     Ps) :-
	argtypes2imports(A, MATs, Ps).
subtype2imports(A, MT, Ps) :- atom2imports(A, MT, Ps).

argtypes2imports(A, [mopstype([_MOI],MT)|MATs], 
	       Ps) :-
	argtypes2imports(A, [MT|MATs], Ps).
argtypes2imports(A, [mopstype([_MOI|MOIs],MT)|MATs], 
	       Ps) :-
	argtypes2imports(A, [MT,mopstype(MOIs,MT)|MATs], Ps).
argtypes2imports(A, [MT|MATs], 
	       Ps) :-
	subtype2imports(A, MT, Ps1), 
	argtypes2imports(A, MATs, Ps2),
	append(Ps1, Ps2, Ps).
argtypes2imports(_A, [], []).

labelfields2imports(A, [mopstype(_,MT)], 
		    Ps) :-
	type2imports(A, MT, Ps).
labelfields2imports(A, [MOT|MOTs], 
		    Ps) :-
	labelfields2imports(A, [MOT], Ps1), 
	labelfields2imports(A, MOTs, Ps2), 
	append(Ps1, Ps2, Ps).

atom2imports(A, MT, Ps) :-
	atom(MT),
	auto_loaded(MT) -> 
	Ps = [] ;
	cons_set(MT) -> 
	concat_atom(['Cons/', MT, '/', A], MA),
	Ps = [:- ensure_loaded(MA)] ;
	concat_atom(['Data/', MT, '/ABS'], MA),
	Ps = [:- ensure_loaded(MA)].

auto_loaded('State').
auto_loaded('Final').
auto_loaded('Label').
auto_loaded('Unobs').

auto_loaded('Atom').
auto_loaded('Boolean').
auto_loaded('Character').
auto_loaded('Integer').
auto_loaded('Set').
auto_loaded('List').
auto_loaded('Map').
auto_loaded('Sequence').
/*
auto_loaded('Env').
auto_loaded('Id').
auto_loaded('Bindable').
auto_loaded('Store').
auto_loaded('Cell').
auto_loaded('Storable').
*/

item2clauses(_, mvartype(mvarid(MTI1,[],[],[]),MT2), 
	     [declare(MTI1:PT2)]) :-
	type2term(MT2, PT2).
item2clauses(_, mtype(MT), 
	     [declare('_':PT)]) :-
	type2term(MT, PT).
item2clauses(A, mtypeincl(mvartype(mvarid(MTI1,[],[],[]),MT2),MSTs), 
	     [declare(MTI1:PT2)|Ps]) :-
	type2term(MT2, PT2),
	item2clauses(A, mtypeincl(mtype(MT2),MSTs), Ps).
item2clauses(A, mtypeincl(mtype(MT),[MST1,MST2|MSTs]), 
	     Ps) :-
	item2clauses(A, mtypeincl(mtype(MT),[MST1]), Ps1), 
	item2clauses(A, mtypeincl(mtype(MT),[MST2|MSTs]), Ps2),
	append(Ps1, Ps2, Ps).
item2clauses(_, mtypeincl(mtype(MT),[MST]), 
	     [declare(PT1>PT2)]) :- 
	type2term(MT, PT1),
	subtype2term(MST, PT2).
% Ignoring selectors for now
item2clauses(A, mtypeeq(mvartype(mvarid(MTI1,[],[],[]),MT2),MT3), 
	     [declare(MTI1:PT2)|Ps]) :-
	type2term(MT2, PT2),
	item2clauses(A, mtypeeq(mtype(MT2),MT3), Ps).
item2clauses(_, mtypeeq(mtype(MT1),MT2), 
	     [declare(PT1=PT2)]) :- 
	type2term(MT1, PT1), type2term(MT2, PT2).
item2clauses(_, mtypeeq(mtype('Label'),mlabeltype(MOTs)), 
	     Ps) :-
	labelfields2clauses(MOTs, Ps).

/* Rules:
   Operations in terms are generally restricted to constructors,
   except when the application is the left side of an equation.
*/
item2clauses(_, mrule([],MT), 
	     [PR]) :-
	cond2agoal(MT, PA),
	label2check(PA, PA1, PG0),
	cond2check(MT, PG),
	normalize((PG0,PG), PG1),
	(   PG1 = true -> 
	PR = PA1 ; 
	PR = (PA1 :- PG1) ).
item2clauses(_, mrule(MCs,MT), 
	     [PA1 :- PG3]) :-
	conds2goal(MCs, PG), 
	cond2agoal(MT, PA), 
	label2check(PA, PA1, PG0),
	cond2check(MT, (PG1,PG2)),
	normalize((PG0,PG1,PG,PG2),PG3).
item2clauses(_, mpredapp(eq, MT1, MT2),
	     [PA]) :-
	cond2agoal(mpredapp(eq, MT1, MT2), PA).

/* Imports
*/
item2clauses(_, mimports(_),
	     []).

/* Untranslated
*/

item2clauses(_, AT, 
	     [AT]) :- atomic(AT).
item2clauses(_, M, 
	     [msos(M)]) :-
	nl, write('WARNING: translation to Prolog failed!'), nl, nl.

/* Types and subtypes
*/
type2term(mtupletype([MT]), 
	     [PT]) :- 
	type2term(MT,PT).
type2term(mtupletype([MT|MTs]), 
	     [PT|PTs]) :- 
	type2term(MT,PT), type2term(mtupletype(MTs), PTs).
type2term(mtypeapp(mtupletype(MTs),MTO), 
	     PT) :- 
	type2term(mtupletype(MTs),PTs), PT =.. [MTO|PTs].
type2term(mtypeapp(MT,MTO), 
	     PT) :- 
	type2term(MT,PT1), PT =.. [MTO,PT1].
type2term(A, PA) :- atom2atom(A, PA).

subtype2term(mtypeapp(mtupletype(MTs),MTO), 
	     PT) :- 
	argtypes2terms(MTs,PTs), PT =.. [MTO|PTs].
subtype2term(mtypeapp(MT,MTO), 
	     PT) :- 
	subtype2term(MT,PT1), PT =.. [MTO,PT1].
subtype2term(mconsdec(MOI,[]), 
	     [PA]) :-
	atom2atom(MOI, PA).
subtype2term(mconsdec(MOI,MATs), 
	     PT) :-
	argtypes2terms(MATs, PTs), term2term(MOI, PA), PT =.. [PA|PTs].
subtype2term(A, PA) :- atom2atom(A, PA).

argtypes2terms([mopstype([_MOI],MT)|MATs], 
	       PTs) :-
	argtypes2terms([MT|MATs], PTs).
argtypes2terms([mopstype([_MOI|MOIs],MT)|MATs], 
	       PTs) :-
	argtypes2terms([MT,mopstype(MOIs,MT)|MATs], PTs).
argtypes2terms([MT|MATs], 
	       [PT|PTs]) :-
	subtype2term(MT, PT), argtypes2terms(MATs, PTs).
argtypes2terms([], []).

labelfields2clauses([mopstype([MOI,primed(MOI)],_MT)], 
		    [readable(PA),writable(PA)]) :-
	atom2atom(MOI, PA).
labelfields2clauses([mopstype([primed(MOI)],_MT)], 
		    [writable(PA)]) :-
	atom2atom(MOI, PA).
labelfields2clauses([mopstype([MOI],_MT)], 
		    [readable(PA)]) :-
	atom2atom(MOI, PA).
labelfields2clauses([MOT|MOTs], 
		    Ps) :-
	labelfields2clauses([MOT], Ps1), 
	labelfields2clauses(MOTs, Ps2), 
	append(Ps1, Ps2, Ps).

/* Conditions
*/
conds2goal([MC|MCs], (PG1,PA,PG2,PG)) :- 
	cond2agoal(MC, PA), 
	cond2check(MC, (PG1,PG2)),
	conds2goal(MCs, PG).
conds2goal([], true).

normalize(G, G1) :-
	goal2goals(G, As),
	list_to_set(As, As1),
	subtract(As1, [true], As2),
	goals2goal(As2, G1).

goal2goals(A, [A]) :- 
	A \= (_,_), A \= true.
goal2goals(true, []).
goal2goals((G1,G2), As) :-
	goal2goals(G1, As1),
	goal2goals(G2, As2),
	append(As1, As2, As).

goals2goal([], true).
goals2goal([A], A).
goals2goal([A|As], (A,G)) :- goals2goal(As,G).

cond2agoal(mtrans(MT1,MT2,MT3), 
	  PT1 ---PT2---> PT3) :- 
	term2typedterm(MT1, PT1), term2term(MT2, PT2), term2term(MT3, PT3).
cond2agoal(mtranseq(MT1,MT2,MT3), 
	  PT1 ===PT2===> PT3) :- 
	term2typedterm(MT1, PT1), term2term(MT2, PT2), term2term(MT3, PT3).
cond2agoal(mtransstar(MT1,MT2,MT3), 
	  PT1 ---PT2--->* PT3) :- 
	term2term(MT1, PT1), term2term(MT2, PT2), term2term(MT3, PT3).
cond2agoal(mpredapp(def,MT), 
	  eq(PT,'_')) :-
	term2term(MT, PT).
cond2agoal(mnegform(MF), 
	  \+ PC) :-
	cond2agoal(MF, PC).
cond2agoal(mpredapp(eq,MT1,MT2), 
	  eq(PT1,PT2)) :- 
	term2term(MT1, PT1), term2term(MT2, PT2).
cond2agoal(mapp([=,MT1,MT2]), 
	  eq(PT1,PT2)) :- 
	term2term(MT1, PT1), term2term(MT2, PT2).
cond2agoal(msplit(MT,MT1,MT2), 
	  seq_concat(PT1,PT2,PT)) :- 
	term2term(MT, PT), term2term(MT1, PT1), term2term(MT2, PT2).
cond2agoal(mappend(MT1,MT2,MT), 
	  seq_concat(PT1,PT2,PT)) :- 
	term2term(MT, PT), term2term(MT1, PT1), term2term(MT2, PT2).
cond2agoal(MT, 
	  eq(PT,true)) :-
	term2term(MT, PT).

/* cond2check(MC, (PG1,PG2)) sets PG1 and PG2 to goals
   where PG1 checks as much as possible before MC is tried
   and PG2 checks whatever results from the success of MC
*/

cond2check(mtrans(MT1,MT2,MT3), 
	   ((PG11,PG12,PG22,PG23),(PG21,PG24,PG31,PG32))) :-
	checktype(MT1, 'State', PG11),
	checkvars(MT1, PG12),
	checktype(MT2, 'Label', PG21),
	checkunobs(MT2, PG22),
	checkreads(MT2, PG23),
	checkwrites(MT2, PG24),
	checktype(MT3, 'State', PG31),
	checkvars(MT3, PG32).
cond2check(mtransstar(MT1,MT2,MT3), PG) :- 
	cond2check(mtrans(MT1,MT2,MT3), PG).
cond2check(mtranseq(MT1,MT2,MT3), PG) :- 
	cond2check(mtrans(MT1,MT2,MT3), PG).
cond2check(mpredapp(eq,MT1,MT2),
	   (PG1,PG2)) :-
	checkvars(MT1, PG1),
	checkvars(MT2, PG2).
cond2check(msplit(MT,MT1,MT2),
	   (PG1,(PG21,PG22))) :-
	checkvars(MT, PG1),
	checkvars(MT1, PG21),
	checkvars(MT2, PG22).
cond2check(mappend(MT1,MT2,MT),
	   ((PG11,PG12),PG2)) :-
	checkvars(MT1, PG11),
	checkvars(MT2, PG12),
 	checkvars(MT, PG2).
cond2check(mpredapp(_,MT1),
	   (PG1,true)) :-
	checkvars(MT1, PG1).
cond2check(mnegform(MF),
	   (PG1,true)) :-
	checkvars(MF, (PG1, _)). 
% any check on new vars should be inside \+ !

cond2check(_M, (true,true)).

checktype(_MT, _T, true).

checkvars(MVI, check(PA:QA)) :-
	MVI = mvarid(MTI,_,_,[]), 
	term2term(MVI, PA),
	concat_atom(['\'',MTI,'\''], QA).
checkvars(MVI, check(PA:TA)) :-
	MVI = mvarid(MTI,_,_,[O]), 
	term2term(MVI, PA),
	concat_atom(['\'',MTI,'\''], QA),
	addtypeop(O, QA, TA).
checkvars(A, true) :- 
	atomic(A).
checkvars(mapp([MOI,MT|MTs]), (PG1,PG2)) :-
	checkvars(MT, PG1), checkvars(mapp([MOI|MTs]), PG2).
checkvars(mapp([_]), true).
checkvars(mlabel(_,_), true).
checkvars(mtermtype(MT,_), PG) :-
	checkvars(MT, PG).
checkvars(mmap([MT|MTs]), (PG1,PG2)) :-
	checkvars(MT, PG1), checkvars(mmap(MTs), PG2).
checkvars(mmap([]), true).
checkvars(mmapterm(MT1,MT2), (PG1,PG2)) :-
	checkvars(MT1, PG1), checkvars(MT2, PG2).
checkvars(mset([MT]), PG) :-
	checkvars(MT, PG).



addtypeop(s, QA, *(QA)).
addtypeop(p, QA, +(QA)).
addtypeop(q, QA, ?(QA)).


checkunobs(MVI, check(PA:QA)) :-
	MVI = mvarid(MTI,_,_,_), 
	term2term(MVI, PA),
	concat_atom(['\'',MTI,'\''], QA).
checkunobs(A, true) :- 
	atomic(A).
checkunobs(mapp(_), true).
checkunobs(mlabel(_,MVI), true) :- 
	MVI = mvarid('X',_,_,_).
checkunobs(mlabel(_,MVI), check(PA:QA)) :-  
	MVI = mvarid(MTI,_,_,_), 
	term2term(MVI, PA),
	concat_atom(['\'',MTI,'\''], QA).

checkreads(_MT, true).

checkwrites(_MT, true).

label2check(PT1---PT2--->PT3, PT1---PA2--->PT3, PA) :-
	atom(PT2) -> 
	PA2 = PT2, PA = true ;
	PA2 = 'X_', PA = eq_label('X_', PT2).
label2check(PT1===PT2===>PT3, PT1===PA2===>PT3, PA) :-
	atom(PT2) -> 
	PA2 = PT2, PA = true ;
	PA2 = 'X_', PA = eq_label('X_', PT2).


/* Terms
*/

term2typedterm(mvarid(MTI,Ds,Ps,Os), A:QA) :-
	atom_chars(MTI,Us), flatten([Us,Ds,Ps,Os], Cs), name(A, Cs),
	concat_atom(['\'',MTI,'\''], QA).
term2typedterm(mtermtype(MT1,MT2), PT1:QA) :-
	term2term(MT1, PT1), atom(MT2), concat_atom(['\'',MT2,'\''], QA).

atom2atom(-, -).
atom2atom(A, A1) :- 
	atomic(A), concat_atom(As, -, A), concat_atom(As, '_', A1).

term2term(A, A1) :- atom2atom(A, A1).
term2term(mvarid(MTI,Ds,Ps,Os), A) :-
	atom_chars(MTI,Us), flatten([Us,Ds,Ps,Os], Cs), name(A, Cs).
term2term(mapp([mvarid(MTI,Ds,Ps,Os)|MTs]), PT) :-
	term2term(mapp([app_op,mvarid(MTI,Ds,Ps,Os)|MTs]), PT), !.
term2term(mapp([+>|MTs]), 
	  map([PT])) :-
	terms2terms(MTs, PTs), PT =.. [+>|PTs].
term2term(mapp([MOI]), 
	  PT) :-
	atom2atom(MOI, PA), PT =.. [PA,[]].
term2term(mapp(MTs), 
	  PT) :-
	terms2terms(MTs, PTs), PT =.. PTs.
term2term(mlabel([MOT],MVI), 
	  [PT|PA]) :-
	labelfield2term(MOT, PT),
	term2term(MVI,PA).
term2term(mlabel([MOT|MOTs],MVI), 
	  [PT|PTs]) :- 
	labelfield2term(MOT, PT), 
	term2term(mlabel(MOTs,MVI), PTs).
term2term(mlabel([],MVI), 
	  PA) :-
	term2term(MVI,PA).
term2term(mmap([MMT]),
	  map([PT])) :-
	mapfield2term(MMT, PT).
term2term(mmap([MMT|MMTs]),
	  map([PT|PTs])) :-
	mapfield2term(MMT, PT),
	term2term(mmap(MMTs), map(PTs)).
term2term(mset([MT]),
	  set([PT])) :-
	term2term(MT, PT).

labelfield2term(mopterm(MOI,MT), 
		PA = PT) :- 
	atom2atom(MOI, PA), term2term(MT, PT).
labelfield2term(mopprimeterm(MOI,MT), 
		PA += PT) :- 
	atom2atom(MOI, PA), term2term(MT, PT).

mapfield2term(mmapterm(MT1,MT2),
	      PT1 +> PT2) :-
	term2term(MT1, PT1), term2term(MT2, PT2).

terms2terms([MT|MTs], [PT|PTs]) :- 
	term2term(MT, PT), 
	terms2terms(MTs, PTs).
terms2terms([], []).

add_defaults(M, A, MA) :-
	concat_atom([MN|_], '/', M),
	( cons_set(MN) -> P = 'Cons/' ; P = '' ),
	concat_atom([P, M, '/', A], MA).

cons_set('Abs').
cons_set('Arg').
cons_set('Cmd').
cons_set('Dec').
cons_set('Exp').
cons_set('Id').
cons_set('Op').
cons_set('Par').
cons_set('Prog').
cons_set('Sys').
cons_set('Type').
cons_set('Var').

cons_set('Term').


