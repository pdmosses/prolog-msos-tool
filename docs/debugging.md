---
layout: default
title: Debugging
nav_order: 5
parent: Prolog MSDF Tools
---

# Debugging

To locate mistakes in MSDF files or in programs, progressively remove
the correct parts...

To determine the last step of a computation that fails, try to
determine a close upper bound on the length of the computation using
`run(...,...,M)`, then use `run(...,...,M, N)` to print the states leading
up to the stuck state.

Please check that any unexpected results obtained when using the MSOS
Tool are repeatable in a fresh Prolog session, then report them to
[the author](mailto:p.d.mosses@swansea,ac.uk).

Kindly report also any inconsistencies between this guide and the
behaviour exhibited by the tool.
