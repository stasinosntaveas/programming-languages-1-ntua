read_and_just_print_codes(File) :-
    open(File, read, Stream),
    repeat,
    read_line_to_codes(Stream, X),
    ( X \== end_of_file -> writeln(X), fail ; close(Stream), ! ).

read_and_return(File, N, Grid) :-
    open(File, read, Stream),
    read_line(Stream, [N]),
    read_grid(Stream, N, Grid),
    close(Stream).

read_grid(Stream, N, Grid) :-
    ( N > 0 ->
    Grid = [Row|Rows],
        read_line(Stream, Row),
        N1 is N - 1,
        read_grid(Stream, N1, Rows)
    ; N =:= 0 ->
    Grid = []
    ).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).

head([[A|_]|_], D) :- % fisrt element
    D = A.

moves(Stream, Moves) :-
    read_and_return(Stream, N, Grid),
    head(Grid, First),
    Prev is First + 1,
    once(check(N, Grid, Moves, [[1, 1, [], Prev]])).


check(_, _, Moves, []) :-
    Moves = 'IMPOSSIBLE',
    retractall(visited(_, _)).

:-dynamic visited/2.

check(N, Grid, Moves, [[X, Y, M, Prev]|B]) :-
    (
        \+ visited(X, Y),
        assertz(visited(X, Y)),
        nth1(Y, Grid, Row),
        nth1(X, Row, Cell),
        Cell < Prev,
        (
            X = N,
            Y = N,
            Moves = M,
            retractall(visited(_, _))
            ;
            X1 is X-1,
            X2 is X+1,
            Y1 is Y-1,
            Y2 is Y+1,
            append(M, [s], Movess),
            append(M, [e], Movese),
            append(M, [n], Movesn),
            append(M, [w], Movesw),
            append(M, [se], Movesse),
            append(M, [sw], Movessw),
            append(M, [nw], Movesnw),
            append(M, [ne], Movesne),
            append(B,  [[X1, Y1, Movesnw, Cell]], BA),
            append(BA, [[X , Y1, Movesn , Cell]], BB),
            append(BB, [[X2, Y1, Movesne, Cell]], BC),
            append(BC, [[X1, Y , Movesw , Cell]], BD),
            append(BD, [[X2, Y , Movese , Cell]], BE),
            append(BE, [[X1, Y2, Movessw, Cell]], BF),
            append(BF, [[X , Y2, Movess , Cell]], BG),
            append(BG, [[X2, Y2, Movesse, Cell]], BH),
            check(N, Grid, Moves, BH)
        )
        ;
        check(N, Grid, Moves, B)
    ).
