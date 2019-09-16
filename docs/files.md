---
layout: default
title: Files
nav_order: 1
parent: Prolog MSOS Tool
---

# Files

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
