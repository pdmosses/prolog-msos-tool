---
layout: default
nav_exclude: true
---

# Prolog MSDF Tools

> User Interface Overview

> Peter D. Mosses <p.d.mosses@swansea.ac.uk>

> Last edited: 13 September 2019

CONTENTS

* Downloading
* Files
* Prolog
* Loading
* Using Generated Files
* Generating Files
* Debugging

The code in the [MSOS] folder was developed between 2001 and 2004,
at the Department of Computer Science, Aarhus University, Denmark.
It was used in connection with undergraduate lectures on
_Fundamental Concepts and Formal Semantics of Programming Languages_.
See the [lecture notes] for explanations and exercises.

The only changes made in the present version concern the filename
extension used for Prolog files (which is now `.pro` instead of `.pl`).
The code should run without errors or warnings using [SWI-Prolog],
otherwise kindly send a bug report to p.d.mosses@swansea.ac.uk,
including relevant details of how to replicate the problem.

[MSOS]: MSOS
  "Folder with MSDF and Prolog code"

[SWI-Prolog]: https://www.swi-prolog.org
  "SWI-Prolog home page"

[Lecture notes]: Notes.pdf
  "PDF of lecture notes"

----

## DOWNLOADING

The original MSOS code is available for browsing at:

* http://cs.swansea.ac.uk/~cspdm/MSOS/

and for downloading as a zip archive:

* http://cs.swansea.ac.uk/~cspdm/MSOS.zip

To unpack the archive and create or update the MSOS directory:
```
unzip MSOS.zip
```

Note: Before updating from a new zip archive, rename your previous MSOS.
This ensures that obsolete files are removed from MSOS, and prevents
overwriting of any files that you have added to your copy of MSOS.

----

## FILES

All the main files implementing the Tool are in the Tool directory.

The following files from other directories are loaded automatically:
```
  Lang/Lex/LEX.pro
  Lang/MSDF/SYN.pro
  Data/Auto/ABS.pro
  Data/Auto/APP.pro
```
All the other Prolog files loaded by the tool are generated using
the tool itself from MSDF files, and stored together with the
corresponding MSDF files, as follows:

Sets of Abstract Constructs
```
  Cons/*/ABS.msdf, ABS.pro: abstract syntax
  Cons/*/CHK.msdf, CHK.pro: static semantics
  Cons/*/RUN.msdf, RUN.pro: dynamic semantics
```

Abstract Constructors
```
  Cons/*/*/ABS.msdf, ABS.pro: abstract syntax
  Cons/*/*/CHK.msdf, CHK.pro: static semantics
  Cons/*/*/RUN.msdf, RUN.pro: dynamic semantics
```

Concrete Languages
```
  Lang/*/*/ABS.msdf, ABS.pro: abstract syntax
  Lang/*/*/CHK.msdf, CHK.pro: static semantics
  Lang/*/*/RUN.msdf, RUN.pro: dynamic semantics
  Lang/*/*/CFG.pro,   SYN.pro: concrete syntax  
  Lang/*/*/CHK-init.pro: static semantics labels
  Lang/*/*/RUN-init.pro: dynamic semantics labels
```

----

## PROLOG

It is assumed that Prolog is installed, and that you know how to start
it and enter queries. Familiarity with Definite Clause Grammars (DCGs)
in Prolog is needed in connection with specifying concrete syntax of
programming languages and its mapping to abstract constructs.

The tool has been tested using the SWI-Prolog v8.1 Free Software
environment under MacOS 10.12. Please inform the author about any
problems experienced when using the tool with different versions of
Prolog.

SWI-Prolog is available for downloading via <http://www.swi-prolog.org>.

PDT, an Eclipse plugin for Prolog, is available via
<https://sewiki.iai.uni-bonn.de/research/pdt/docs/start>.

Note: In SWI-Prolog, the query
```
  ?- emacs.
```
starts a GUI with an integrated and simplified version of Emacs.
(The `?-` is the usual prompt from SWI-Prolog, but it may differ on
other implementations.)

Note: Emacs has a Prolog mode. However, editing a file with extension
`.pro` may not use Prolog mode by default, in which case you should
either load prolog-mode explicitly, change the Emacs defaults to load
prolog-mode, or insert Emacs directives as comments in the files.

----

## LOADING

Start Prolog from the `MSOS` directory.

Load the file 'Tool/load.pro', either using Emacs or the query:
```
  ?- ['Tool/load.pro'].
```
This should cause a number of other files to be loaded, without any
errors or warnings.

----

## USING GENERATED FILES

For every MSDF file (with extension `.msdf`) in the MSOS repository,
there should be a corresponding generated Prolog file (with extension
`.pro`). If you make any changes to an MSDF file, you should regenerate
the Prolog file, see GENERATING FILES below.

The repository includes files for parsing, checking, and running
programs in the simple illustrative languages described in:

> _Fundamental Concepts and Formal Semantics of Programming Languages_  
> Peter D. Mosses, 2004 <http://www.cs.swan.ac.uk/~cspdm/MSOS/Notes.pdf>

* bc/1: a simple subset of the imperative language bc (see Chapter 1).

* ML/Exp, ML/Dec, ML/Cmd, ML/Abs, and ML/Conc: an increasing series of
  sublanguages of Standard ML (see Chapters 5-8), finishing with some
  constructs reminiscent of synchronous processes in Concurrent ML
  (see Chapter 9).

N.B.: When switching between sublanguages of bc and sublanguages of
ML, start a fresh Prolog session, otherwise unexpected results may
arise.  (This should not be necessary when switching between different
sublanguages of ML.)

A test program can be given as a string `"..."` or by the name of a file
that contains it `'...'`.

Note: When a test program for a particular language X/Y is stored in
the file Test/X/Y/Z, the name of the file can be abbreviated to `'Z'`
(the quotes can also be omitted if Z is a lowercase word or a number),
otherwise the full path (relative to MSOS, or absolute) has to be given.

Note: It is assumed below that the files for the language X/Y are
stored in the directory Lang/X/Y, otherwise 'X/Y' has to be replaced
by the full path (relative to MSOS, or absolute) of the relevant
directory, and the name of the test program cannot be abbreviated.

```
?- parse('X/Y', ...).
```
   Example: `parse('bc/1', "2+2").`

   The query `parse('X/Y', ...)` uses the grammar in `Lang/X/Y/SYN.pro` to
   parse the given program, checking that the structure of the resulting
   abstract syntax tree has the structure specified by `Lang/X/Y/ABS.msdf`.

```
?- check('X/Y', ...).
```
   Example: `check('bc/1', "2+2").`

   Note: This query isn't available yet for the sublanguages of ML.

   The query `check('X/Y', ...)` uses the grammar in `Lang/X/Y/SYN.pro` to
   parse the given program, checking that the structure of the resulting
   abstract syntax tree has the structure specified by `Lang/X/Y/ABS.msdf`.

   It then checks the type of the program, using the static semantics
   specified by `Lang/X/Y/CHK.msdf`. The readable components of the label
   for the first step are specified in `Lang/X/Y/CHK-init.pro`; the writable
   components are left as (anonymous) variables.

   If the program is statically correct, the type of the program (e.g.,
   `void`) is printed; otherwise, the query fails (so Prolog prints `false`).

```
?- run('X/Y', ...).
```
   Example: `run('bc/1', "2+2").`

   The query `run('X/Y', ...)` uses the grammar in `Lang/X/Y/SYN.pro` to
   parse the given program, checking that the structure of the resulting
   abstract syntax tree has the structure specified by `Lang/X/Y/ABS.msdf`.

   It then runs the program until it terminates, using the dynamic
   semantics specified by `Lang/X/Y/RUN.msdf`. The readable components of
   the label for the first step are specified in `Lang/X/Y/RUN-init.pro`;
   the writable components are left as (anonymous) variables.

   If the computation terminates in a final state, the final state (e.g.,
   skip) is printed; if it terminates in a stuck state, the query fails
   (so Prolog prints `false`); a nonterminating query can be interrupted
   using Control-C (followed by `a` to abort the query).

   The label obtained by composing the trace of the computation is
   also printed.

```
?- hide_parse.
```
   This supresses the printing of the result of parsing. It is
   especially useful before using `run('X/Y', ...)` with a fully-tested
   semantics.

```
?- show_parse.
```
   This reactivates the printing of the result of parsing.

```
?- run('X/Y', ..., M).
```
   Example: `run('bc/1', "2+2", 2).`

   This limits the length of the computation to `M` steps (`M>=0`).

   If the computation terminates in a final state, the final state (e.g.,
   `skip`) is printed; if it terminates in a stuck state, the query fails
   (so Prolog prints `false`); if it hasn't terminated after `M` steps, the
   `M`th state of the computation is printed (and Prolog prints `true`).

```
?- run('X/Y', ..., M, N).
```
   Example: `run('bc/1', "2+2", 99, 0).`

   This limits the length of the computation to `M` steps (`M>=0`),
   and prints the intermediate states starting from the `N`th step
   (`M>=N>=0`). If the computation terminates before the `M`th state,
   the query fails (so Prolog prints `false`).

```
?- hide_label.
```
   This supresses the printing of labels. It is especially useful before
   using `run('X/Y', ..., M, N)`.

```
?- show_label.
```
   This reactivates the printing of labels.

----

## GENERATING FILES

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

```
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

```
?- cons('X/Y').
```
   Example: `cons('Cmd/cond-nz').`

   This query is analogous to `cons('X')` above.

```
?- lang('X/Y').
```
   Example: `lang('bc/1').`

   This query translates the MSDF specifications in `Lang/X/Y/ABS.msdf`,
   `Lang/X/Y/CHK.msdf`, and `Lang/X/Y/RUN.msdf` to Prolog. If an MSDF file
   isn't found, this is reported.

```
?- test('X/Y').
```
   Example: `test('bc').`

   This query translates the MSDF specifications in `Test/X/Y/ABS.msdf`,
   `Test/X/Y/CHK.msdf`, and `Test/X/Y/RUN.msdf` to Prolog. If an MSDF file
   isn't found, this is reported.

```
?- data('X').
```
   Example: `data('Boolean')`.

   This query translates the MSDF specification in `Data/X/ABS.msdf` to
   Prolog.

```
?- msdf('X', 'ABS').
```
   Example: `msdf('~/PATH', 'ABS').`

   This query translates the MSDF specification in `~/PATH/ABS.msdf`
   to Prolog. Similarly for `CHK` and `RUN` files.

----

## DEBUGGING

To locate mistakes in MSDF files or in programs, progressively remove
the correct parts...

To determine the last step of a computation that fails, try to
determine a close upper bound on the length of the computation using
`run(...,...,M)`, then use `run(...,...,M, N)` to print the states leading
up to the stuck state.

Please check that any unexpected results obtained when using the MSOS
Tool are repeatable in a fresh Prolog session, then report them to the
author.

Kindly report also any inconsistencies between this guide and the
behaviour exhibited by the tool.

----
