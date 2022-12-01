%% sudoku.pl
:- use_module(library(clpfd)).

sudoku(Puzzle, Hor, Ver) :-
    flatten(Puzzle, Tmp), Tmp ins 1..9,
    Rows = Puzzle,
    transpose(Rows, Columns),
    blocks(Rows, Blocks),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    maplist(all_distinct, Blocks),
	compareFull(Rows, Hor),
	transpose(Ver, VerT),
	compareFull(Columns, VerT),
    maplist(label, Rows).

blocks([A,B,C,D,E,F,G,H,I], Blocks) :-
    blocks(A,B,C,Block1), blocks(D,E,F,Block2), blocks(G,H,I,Block3),
    append([Block1, Block2, Block3], Blocks).

blocks([], [], [], []).
blocks([A,B,C|Bs1],[D,E,F|Bs2],[G,H,I|Bs3], [Block|Blocks]) :-
    Block = [A,B,C,D,E,F,G,H,I],
    blocks(Bs1, Bs2, Bs3, Blocks).

compareC(_, _, 'X') :- !.
compareC(A, B, '>'):- A#>B.
compareC(A, B, '<'):- A#<B.

compareAll([H1], []):- !.

compareAll([H1, H2|B], [C1|B2]):-
	compareC(H1, H2, C1),
	compareAll([H2|B], B2).

compareFull([], []) :- !.

compareFull([MH|MB], [CH|CB]):-
	compareAll(MH, CH),
	compareFull(MB, CB).
