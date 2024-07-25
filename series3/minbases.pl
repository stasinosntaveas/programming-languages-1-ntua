minbases([], []).

minbases([A|B], [C|D]) :-
    once(check(A, 2, C)),
    minbases(B, D).

check(A, B, C) :-
    valid_in_base(A, B),
    C = B;
    D is B + 1,
    check(A, D, C).

valid_in_base(A, B) :-
    C is A mod B,
    D is A // B,
    valid(D, B, C).

valid(0, _, _).
valid(A, B, C) :-
    A > 0,
    A mod B =:= C,
    D is A // B,
    valid(D, B, C).
