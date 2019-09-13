/* Computations: */

% unbounded:

S:T ---X--->* F :-
        pre_comp(X, X1),
        S:T ---X1---> S1,
        mid_comp(X1, X2),
        S1:T ---X2--->* F,
        post_comp(X1, X2, X).

F:_ ---U--->* F :- final(F), unobs(U).

% up to at most N steps:

S:T ---X---N>* SN :-
        N =:= 0 -> ( unobs(X), SN = S ) ;
        pre_comp(X, X1),
        S:T ---X1---> S1,
        mid_comp(X1, X2),
        N1 is N - 1,
        S1:T ---X2---N1>* SN,
        post_comp(X1, X2, X).

F:_ ---U---_N>* F :- final(F), unobs(U).


/* Label composition: */

% Records are represented by unordered lists of equations [...,I=A,...]

% unprimed index: I=A  (initial value of label component)
% "primed" index: I+=A (final value of label component)

% The predicates readable and writable could be derived,
% but simpler to specify them for each index I

readable(dummy). writable(dummy).

changeable(I) :- readable(I), writable(I).


% pre_comp(X, X1) sets readable components of X1

pre_comp([I=C|L], X1) :-
        select(I=C, X1, L1), !,
        pre_comp(L, L1).

pre_comp([I+=_C|L], X1) :-
        select(I+=_, X1, L1), !,
        pre_comp(L, L1).

pre_comp([], []).


% mid_comp(X1, X2) sets readable components of X2

mid_comp([I=C1|L1], X2) :-
        ( changeable(I) -> 
            select(I+=_, X2, L2) ;
            select(I=C1, X2, L2) ), !,
        mid_comp(L1, L2).

mid_comp([I+=C1|L1], X2) :-
        ( changeable(I) -> 
            select(I=C1, X2, L2) ;
            select(I+=_, X2, L2) ), !,
        mid_comp(L1, L2).

mid_comp([], []).


% post_comp(X1, X2, X) sets writable components of X

post_comp([_=_|L1], X2, X) :-
        post_comp(L1, X2, X).
        
post_comp([I+=C1|L1], X2, X) :-
        member(I+=C2, X2),
        ( changeable(I) -> 
            member(I+=C2, X) ;
	  eq(^(C1,C2), C), % see Data/Seq/MSOS
%          append(C1, C2, C), % assumes represented as a Prolog list
          member(I+=C, X) ), !,
        post_comp(L1, X2, X).

post_comp([], _X2, _X).


/* Label observability: */

unobs([I=C|L]) :-
        \+ writable(I) -> unobs(L) ;
        select(I+=C, L, L1), unobs(L1).

unobs([I+=C|L]) :-
        \+ readable(I) -> C = null, unobs(L) ;
        select(I=C, L, L1), unobs(L1).

unobs([]).
