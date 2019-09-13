prog(C:'Cmd') --> optnewlines, stmts(C), optnewlines.

stmts(seq(C1,C2)) --> stmt(C1), i, sep, optnewlines, stmts(C2).
stmts(C) --> stmt(C).
sep --> ";".
sep --> newline.
stmt(effect(E)) --> assign_expr(E).
stmt(print(E))  --> normal_expr(E).
stmt(C)    --> "{", optnewlines, stmts(C), optnewlines, "}".
stmt(skip) --> "{", optnewlines, "}".
stmt(cond_nz(E,C)) -->
	"if", i, "(", i, expr(E), i, ")", i, stmt(C).
stmt(while_nz(E,C)) -->
	"while", i, "(", i, expr(E), i, ")", i, stmt(C).

expr(E) --> assign_expr(E).
expr(E) --> normal_expr(E).
assign_expr(assign_seq(VAR,E)) -->
	var(VAR), i, "=", i, expr(E).
normal_expr(app(O,tup_seq(E1,E2))) -->
	grouped_expr(E1), i, infix_op(O), i, normal_expr(E2).
normal_expr(app(ord, app(O,tup_seq(E1,E2)))) -->
	grouped_expr(E1), i, infix_rel(O), i, normal_expr(E2).
normal_expr(E) --> grouped_expr(E).
grouped_expr(VAR) --> var(VAR).
grouped_expr(N) --> num(N).
grouped_expr(E) --> "(", i, expr(E), i, ")".

infix_op(+)   --> "+".  infix_op(-)   --> "-". 
infix_op(*)   --> "*".  infix_op(div) --> "/".
infix_op(mod) --> "%".
infix_rel(<)  --> "<".  infix_rel(=<) --> "<=".
infix_rel(>)  --> ">".  infix_rel(>=) --> ">=".
infix_rel(=)  --> "==". infix_rel(\=) --> "!=".

var(id(L)) --> lower(L).

num(N) --> digits(Ds), { number_chars(N, Ds) }.

i --> optwhites ; "/*", up_to("*/").
newlines --> i, newline, optnewlines.
optnewlines --> newlines ; i.
