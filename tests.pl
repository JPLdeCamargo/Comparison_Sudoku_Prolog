:- use_module(library(clpfd)).

compareC(_, _, 'X') :- !.
compareC(A, B, '<'):- A#<B.
compareC(A, B, '>'):- A#>B.

compareAll([H1], []):- !.

compareAll([H1, H2|B], [C1|B2]):-
	compareC(H1, H2, C1),
	compareAll([H2|B], B2).

compareFull([], []) :- !.

compareFull([MH|MB], [CH|CB]):-
	compareAll(MH, CH),
	compareFull(MB, CB).

my_in(Var, Lower, Upper) :-
        Lower #=< Var, Var #=< Upper.
