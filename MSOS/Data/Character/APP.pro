/* Characters are represented by single-character atoms
*/

check(C:'Character') :- atom(C), atom_length(C, 1).
