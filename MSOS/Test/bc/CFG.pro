prog --> optnewlines, stmts, optnewlines.

stmts --> stmt, i, sep, optnewlines, stmts.
stmts --> stmt.

sep --> ";".
sep --> newline.

stmt --> assign_expr.
stmt --> normal_expr.
stmt --> "{", optnewlines, stmts, optnewlines, "}".
stmt --> "{", optnewlines, "}".
stmt --> "if", i, "(", i, expr, i, ")", i, stmt.
stmt --> "while", i, "(", i, expr, i, ")", i, stmt.

expr --> assign_expr.
expr --> normal_expr.

assign_expr --> var, i, "=", i, expr.

normal_expr --> grouped_expr, i, infix, i, grouped_expr.
normal_expr --> grouped_expr.

grouped_expr --> var.
grouped_expr --> num.
grouped_expr --> "(", i, expr, i, ")".

infix --> "+" ; "-"  ; "*" ; "/"  ; "%"  ; 
          "<" ; "<=" ; ">" ; ">=" ; "==" ; "!=".

var --> lower(_).
num --> digits(_).

i --> optwhites.
i --> "/*", up_to("*/").
newlines --> i, newline, optnewlines.
optnewlines --> newlines ; i.
