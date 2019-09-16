---
layout: default
title: Using generated files
nav_order: 3
parent: Prolog MSOS Tool
---

# Using generated files

For every MSDF file (with extension `.msdf`) in the MSOS repository,
there should be a corresponding generated Prolog file (with extension
`.pro`). If you make any changes to an MSDF file, you should regenerate
the Prolog file, see [Generating files](generating).

The repository includes files for parsing, checking, and running
programs in the simple illustrative languages described in:

> _Fundamental Concepts and Formal Semantics of Programming Languages_  
> Peter D. Mosses, 2004 
> ([PDF](https://github.com/pdmosses/prolog-msos-tool/blob/master/Notes.pdf))

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

```prolog
?- parse('X/Y', ...).
```
   Example: `parse('bc/1', "2+2").`

   The query `parse('X/Y', ...)` uses the grammar in `Lang/X/Y/SYN.pro` to
   parse the given program, checking that the structure of the resulting
   abstract syntax tree has the structure specified by `Lang/X/Y/ABS.msdf`.

```prolog
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

```prolog
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

```prolog
?- hide_parse.
```
   This supresses the printing of the result of parsing. It is
   especially useful before using `run('X/Y', ...)` with a fully-tested
   semantics.

```prolog
?- show_parse.
```
   This reactivates the printing of the result of parsing.

```prolog
?- run('X/Y', ..., M).
```
   Example: `run('bc/1', "2+2", 2).`

   This limits the length of the computation to `M` steps (`M>=0`).

   If the computation terminates in a final state, the final state (e.g.,
   `skip`) is printed; if it terminates in a stuck state, the query fails
   (so Prolog prints `false`); if it hasn't terminated after `M` steps, the
   `M`th state of the computation is printed (and Prolog prints `true`).

```prolog
?- run('X/Y', ..., M, N).
```
   Example: `run('bc/1', "2+2", 99, 0).`

   This limits the length of the computation to `M` steps (`M>=0`),
   and prints the intermediate states starting from the `N`th step
   (`M>=N>=0`). If the computation terminates before the `M`th state,
   the query fails (so Prolog prints `false`).

```prolog
?- hide_label.
```
   This supresses the printing of labels. It is especially useful before
   using `run('X/Y', ..., M, N)`.

```prolog
?- show_label.
```
   This reactivates the printing of labels.
