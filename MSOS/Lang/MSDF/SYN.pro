% parse.pro

/* DCG for parsing MSOS modules
*/

msos(Ms) --> moptblanklines, msos1(Ms), moptblanklines.

msos1([M|Ms]) --> msos2(M), mblanklines, msos1(Ms).
msos1([M]) --> msos2(M).
msos1([]) --> [].

msos2(MD) --> mdec(MD).
msos2(MR) --> mrule(MR).
msos2(MI) --> mimports(MI).

/* Declarations:
*/

mdec(MTD) --> mtypedec(MTD).
mdec(MTD) --> mtypedef(MTD).

mtypedec(mvartype(MVI,MT)) --> 
	mvarid(MVI), m, ":", m, mtype(MT).
mtypedec(mtype(MT)) --> 
	mtype(MT).

mtypedef(mtypeincl(MTD,MSTs)) --> 
	mtypedec(MTD), m, "::=", m, msubtypes(MSTs).
mtypedef(mtypeeq(MTD,MT)) --> 
	mtypedec(MTD), m, "=", m, mtype(MT).

msubtypes([MST|MSTs]) --> 
	msubtype(MST), m, "|", m, msubtypes(MSTs).
msubtypes([MST]) --> 
	msubtype(MST).

msubtype(MT) --> 
	mtype(MT).
msubtype(mconsdec(MOI,MATs)) --> 
	mopid(MOI), m, "(", m, mtypes(MATs), m, ")".
msubtype(mconsdec(MOI,MATs)) --> 
	mopid(MOI), m, "(", m, mopstypes(MATs), m, ")".
msubtype(mconsdec(MOI,[])) --> 
	mopid(MOI).

mtypes([MT|MTs]) --> 
	mtype(MT), m, ",", m, mtypes(MTs).
mtypes([MT]) --> 
	mtype(MT).

mopstypes([MOT|MOTs]) --> 
	mopstype(MOT), m, ",", m, mopstypes(MOTs).
mopstypes([MOT]) --> 
	mopstype(MOT).

mopstype(mopstype(MOIs,MT)) --> 
	mopids(MOIs), m, ":", m, mtype(MT).

mopids([MOI,primed(MOI_1)]) --> 
	mopid(MOI), m, ",", m, mopid(MOI_1), "\'", {MOI=MOI_1}.
mopids([primed(MOI)]) --> 
	mopid(MOI), "\'".
mopids([MOI]) --> 
	mopid(MOI).

mtype(mtypeapp(MT,MTO)) --> 
	mtype1(MT), mtypeop(MTO).
mtype(MT) --> 
	mtype1(MT).

mtype1(MTI) --> 
	mtypeid(MTI).
mtype1(MT) --> 
	"(", m, mtype(MT), m, ")", !.
mtype1(mtupletype(MTs)) --> 
	"(", m, mtypes(MTs), m, ")".
mtype1(mlabeltype(MOTs)) --> 
	"{", m, mopstypes(MOTs), m, ",", m, "...", m, "}".

/* Rules:
*/

mrule(mrule(MCs,MT)) --> 
	mconds(MCs), m, mline, m, mtrans(MT).
mrule(mrule([],MT)) --> 
	mtrans(MT).
mrule(MF) --> mform(MF).

mline --> "----", moptline.

moptline --> "-", !, moptline.
moptline --> "".

mconds([M|Ms]) --> 
	mcond(M), m, ",", m, mconds(Ms).
mconds([M]) --> 
	mcond(M).

mcond(MT) --> mtrans(MT).
mcond(MF) --> mform(MF).

mtrans(mtransstar(MT1,mvarid('U',[],[],[]),MT2)) --> 
	mterm(MT1), m, "--->*", !, m, mterm(MT2).
mtrans(mtrans(MT1,mvarid('U',[],[],[]),MT2)) --> 
	mterm(MT1), m, "--->", m, mterm(MT2).
mtrans(mtranseq(MT1,mvarid('U',[],[],[]),MT2)) --> 
	mterm(MT1), m, "===>", m, mterm(MT2).
mtrans(mtransstar(MT1,MT2,MT3)) --> 
	mterm(MT1), m, "--", m, mterm(MT2), m, "->*", !, m, mterm(MT3).
mtrans(mtrans(MT1,MT2,MT3)) --> 
	mterm(MT1), m, "--", m, mterm(MT2), m, "->", m, mterm(MT3).
mtrans(mtranseq(MT1,MT2,MT3)) --> 
	mterm(MT1), m, "==", m, mterm(MT2), m, "=>", m, mterm(MT3).

% mform(mtypecheck(MT1,MT2)) --> 
% 	mterm(MT1), m, ":", m, mtype(MT2).
mform(mpredapp(eq,MT1,MT2)) --> 
	mterm(MT1), m, "=", m, mterm(MT2).
mform(msplit(MT,MT1,MT2)) --> 
	mterm(MT), m, "=", m, "(", m, mterms([MT1,MT2]), m, ")".
mform(mappend(MT1,MT2,MT)) --> 
	"(", m, mterms([MT1,MT2]), m, ")", m, "=", m, mterm(MT).
mform(mpredapp(def,MT)) --> 
	"def", m, mterm(MT).
mform(mpredapp(unobs,MT)) --> 
	"unobs", m, mterm(MT).
mform(mnegform(MF)) --> 
	"not", m, mform(MF).
mform(MF) --> 
	mterm(MF).

mterm(mtermtype(MT1,MT2)) -->
 	mterm1(MT1), m, ":", m, mtype(MT2).
mterm(MT) -->
 	mterm1(MT).

mterm1(mapp([MOI,MT1,MT2])) --> 
	mterm2([MT1]), m, mneqid(MOI), m, mterm2([MT2]), !.
mterm1(MT) --> 
	mterm2([MT]).

mterm2([mapp([MOI|MTs])]) --> 
	mopid(MOI), m, mterm3(MTs).
mterm2([mapp([MVI|MTs])]) --> 
	mvarid(MVI), m, mterm3(MTs).
mterm2(MTs) --> mterm3(MTs).

mterm3([MOI]) --> 
	mwordid(MOI).
mterm3([MVI]) --> 
	mvarid(MVI).
mterm3([N]) --> 
	mint(N).
mterm3([null]) --> 
	"(", m, ")".
mterm3([MT]) --> 
	"(", m, mterm(MT), m, ")", !.
mterm3([MOI]) --> 
	"(", m, mopid(MOI), m, ")", !.
mterm3(MTs) --> 
	"(", m, mterms(MTs), m, ")".
mterm3([mlabel(MOTs,mvarid('X',[],[],[]))]) --> 
	"{", m, mopterms(MOTs), m, ",", m, "...", m, "}".
mterm3([mlabel([],mvarid('X',[],[],[]))]) --> 
	"{", m, "...", m, "}".
mterm3([mlabel(MOTs,mvarid('U',[],[],[]))]) --> 
	"{", m, mopterms(MOTs), m, ",", m, "---", m, "}".
mterm3([mlabel([],mvarid('U',[],[],[]))]) --> 
	"{", m, "---", m, "}".
mterm3([mfield(MVI,MOI)]) -->
	mvarid(MVI), ".", mopid(MOI).
mterm3([mfieldprime(MVI,MOI)]) -->
	mvarid(MVI), ".", mopid(MOI), "\'".
mterm3([mmap(MTs)]) --> 
	"{", m, mmapterms(MTs), m, "}", !.
mterm3([mapp([list])]) --> 
	"[", m, "]".
mterm3([mapp([set])]) --> 
	"{", m, "}".
mterm3([mset([MT])]) --> 
	"{", m, mterm(MT), m, "}".

mterms([MT|MTs]) --> 
	mterm(MT), m, ",", m, mterms(MTs).
mterms([MT]) --> 
	mterm(MT).

mopterms([MOT|MOTs]) --> 
	mopterm(MOT), m, ",", m, mopterms(MOTs).
mopterms([MOT]) --> 
	mopterm(MOT).

mopterm(mopterm(MOI,MT)) --> 
	mopid(MOI), m, "=", m, mterm(MT).
mopterm(mopprimeterm(MOI,MT)) --> 
	mopid(MOI), "\'", m, "=", m, mterm(MT).

mmapterms([MMT|MMTs]) --> 
	mmapterm(MMT), m, ",", m, mmapterms(MMTs).
mmapterms([MMT]) --> 
	mmapterm(MMT).

mmapterm(mmapterm(MT1,MT2)) --> 
	mterm2([MT1]), m, "|->", m, mterm2([MT2]).

/* Imports
*/

mimports(mimports(MMs)) --> "see", m, mmods(MMs).

mmods([MMI|MMs]) --> 
	mmodid(MMI), m, ",", m, mmods(MMs).
mmods([MMI]) --> 
	mmodid(MMI).

/* Operators and identifiers:
*/

mtypeop(*) --> "*".
mtypeop(+) --> "+".
mtypeop(?) --> "?".
mtypeop('List') --> "List".
mtypeop('Set') --> "Set".
mtypeop('Map') --> "Map".
mtypeop(MTI) --> mtypeid(MTI).

mtypeid(MTI) --> upper(U), malnums(As), 
	{name(MTI,[U|As])}.

mwordid(MOI) --> lower(L), malnums(As), 
	{name(MOI,[L|As]), \+mreserved(MOI)}.
mwordid(MOI) --> "\'", mnoprimes(As), "\'",
	{name(MOI,As)}.

mnoprimes([A|As]) --> graph(A), {A \= '\''}, mnoprimes(As).
mnoprimes([A]) --> graph(A), {A \= '\''}.

mneqid(MOI) --> mwordid(MOI).
mneqid(MOI) --> minfid(MOI).

mopid(MOI) --> mneqid(MOI).
mopid(=) --> "=".

minfid(+) --> "+".
minfid(-) --> "-", not_next("->").
minfid(*) --> "*".
minfid(/) --> "/".
minfid(^) --> "^".
minfid(+>) --> "|->".
minfid(<) --> "<".
minfid(=<) --> "=<".
minfid(\=) --> "\\=".
minfid(>=) --> ">=".
minfid(>) --> ">".

mreserved(def).
mreserved(unobs).
mreserved(not).
mreserved(see).

mint(N) --> digits(Ds), { number_chars(N, Ds) }.

mvarid(mvarid(MTI,Ds,Ps,Os)) --> 
	uppers(Us), optdigits(Ds), moptprimes(Ps), mopttypeop(Os), !,
	{name(MTI,Us)}.
mvarid(mvarid(MTI,Ds,Ps,Os)) --> 
	"_", uppers(Us), optdigits(Ds), moptprimes(Ps), mopttypeop(Os), !,
	{name(MTI,['_'|Us])}.
mvarid(mvarid('_',[],[],[])) --> "_".

moptprimes(['_'|Ps]) --> mprimes(Ps).
moptprimes([]) --> [].

mprimes(['1'|Ps]) --> "\'", mprimes(Ps).
mprimes(['1']) --> "\'".

mopttypeop([s]) --> "*".
mopttypeop([p]) --> "+".
mopttypeop([q]) --> "?".
mopttypeop([]) --> [].

mmodid(MMI) --> alnum(L), malnums(As), "/", mmodid(MMI2),
	{name(MMI1,[L|As]), concat_atom([MMI1, (/), MMI2], MMI)}.
mmodid(MMI) --> alnum(L), malnums(As), 
	{name(MMI,[L|As])}.

malnums([C|Cs]) --> malnum(C), !, malnums(Cs).
malnums([]) --> "".

malnum(C) --> alnum(C).
malnum('-') --> "-".

/* Layout and comments:
*/

mblanklines --> mwhites, newline, mwhites, newline, moptblanklines.
mblanklines --> mwhites, ".", mwhites, newline, moptblanklines.

moptblanklines --> mwhites, newline, moptblanklines.
moptblanklines --> mwhites.

m --> mwhites, newline, !, mwhites.
m --> mwhites.

mwhites --> mwhite, !, mwhites.
mwhites --> "".

mwhite --> white.
mwhite --> "/*", up_to("*/").
