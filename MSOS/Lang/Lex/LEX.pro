% A-Z:

upper(C) --> [C], { char_type(C, upper) }.

uppers([U|Us]) --> upper(U), optuppers(Us).

optuppers([U|Us]) --> upper(U), optuppers(Us).
optuppers([]) --> "".

% a-z:

lower(C) --> [C], { char_type(C, lower) }.

% A-Z, a-z:

alpha(C) --> [C], { char_type(C, alpha) }.

% 0-9:

digit(C) --> [C], { char_type(C, digit) }.

digits([D|Ds]) --> digit(D), optdigits(Ds).

optdigits([D|Ds]) --> digit(D), optdigits(Ds).
optdigits([]) --> "".

% A-Z, a-z, 0-9:

alnum(C) --> [C], { char_type(C, alnum) }.

optalnums([C|Cs]) --> alnum(C), optalnums(Cs).
optalnums([]) --> "".

% A-Z, a-z, 0-9, _:

csym(C) --> [C], { char_type(C, csym) }.

optcsyms([C|Cs]) --> csym(C), optcsyms(Cs).
optcsyms([]) --> "".

% visible characters:

graph(C) --> [C], { char_type(C, graph) }.

% space, tab:

white --> [C], { char_type(C, white) }.

whites --> white, optwhites.

optwhites --> whites.
optwhites --> "".

% newline on Unix-like systems:

newline --> [C], { char_type(C, end_of_line) }.

% spaces, tabs, newlines on Unix-like systems:

whitelines --> optwhites, newline, optwhitelines.

optwhitelines --> whitelines.
optwhitelines --> "".
