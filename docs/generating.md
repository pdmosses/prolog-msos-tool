---
layout: default
title: Generating files
nav_order: 4
parent: Prolog MSOS Tool
---

# Generating files

For every MSDF file (with extension `.msdf`) in the `MSOS` repository,
there should be a corresponding generated Prolog file (with extension
`.pro`). If you add a new MSDF file, or make any changes to an
existing MSDF file, you should (re)generate the Prolog file, see below.

The MSOS repository includes MSDF specifications of the abstract
syntax and semantics of various constructs and sets of constructs.

If X is a set of constructs, the files for X are stored in `Cons/X`.

Example: The files for `Exp` are stored in `Cons/Exp`.

If Y is a construct belonging to X, the files for Y are stored in
`Cons/X/Y`, or in `Cons/X/Y-...` if the construct is a variant or special
case of another construct.

Example: The files for `Exp::=app(Exp,Arg)` are stored in `Cons/Exp/app`,
and those for `Exp::=app(Op,Arg)` are stored in `Cons/Exp/app-Op`.

The MSDF specification of the abstract syntax of a construct is stored
in the file `ABS.msdf`, that of its static semantics in `CHK.msdf`, and
that of its dynamic semantics in `RUN.msdf`. The same goes for sets of
constructs.

```prolog
?- cons('X').
```
   Example: `cons('Exp').`

   This query translates the MSDF specifications in `Cons/X/ABS.msdf`,
   `Cons/X/CHK.msdf`, and `Cons/X/RUN.msdf` to Prolog. If an MSDF file
   isn't found, this is reported.

   For each MSDF specification, the file is printed. If its parsing
   and translation to Prolog is successful, the generated Prolog file
   is written, the generated Prolog file is loaded, and 'OK' is
   printed. (If the parsing or translation fails, OK is NOT printed,
   and no Prolog file is generated or loaded.)

```prolog
?- cons('X/Y').
```
   Example: `cons('Cmd/cond-nz').`

   This query is analogous to `cons('X')` above.

```prolog
?- lang('X/Y').
```
   Example: `lang('bc/1').`

   This query translates the MSDF specifications in `Lang/X/Y/ABS.msdf`,
   `Lang/X/Y/CHK.msdf`, and `Lang/X/Y/RUN.msdf` to Prolog. If an MSDF file
   isn't found, this is reported.

```prolog
?- test('X/Y').
```
   Example: `test('bc').`

   This query translates the MSDF specifications in `Test/X/Y/ABS.msdf`,
   `Test/X/Y/CHK.msdf`, and `Test/X/Y/RUN.msdf` to Prolog. If an MSDF file
   isn't found, this is reported.

```prolog
?- data('X').
```
   Example: `data('Boolean')`.

   This query translates the MSDF specification in `Data/X/ABS.msdf` to
   Prolog.

```prolog
?- msdf('X', 'ABS').
```
   Example: `msdf('~/PATH', 'ABS').`

   This query translates the MSDF specification in `~/PATH/ABS.msdf`
   to Prolog. Similarly for `CHK` and `RUN` files.
