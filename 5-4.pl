% Hyp1: If A violated, then B violated.
hyp1(A, B, _, _) :-
    (A =:= 1 -> B =:= 1 ; true).

% Hyp2: If B violated, then C violated or A did not violate.
hyp2(_, B, C, A) :-
    (B =:= 1 -> (C =:= 1 ; A =:= 0) ; true).

% Hyp3: If D did not violate, then A violated and C did not violate.
hyp3(A, _, C, D) :-
    (D =:= 0 -> (A =:= 1, C =:= 0) ; true).

% Hyp4: If D violated, then A violated.
hyp4(A, _, _, D) :-
    (D =:= 1 -> A =:= 1 ; true).

% Variants: 0 — did not violate, 1 — violated.
variant(0).
variant(1).

% Main check.
check_combination(A, B, C, D) :-
    variant(A), variant(B), variant(C), variant(D),
    (hyp1(A, B, C, D) -> V1 = 1 ; V1 = 0),
    (hyp2(A, B, C, D) -> V2 = 1 ; V2 = 0),
    (hyp3(A, B, C, D) -> V3 = 1 ; V3 = 0),
    (hyp4(A, B, C, D) -> V4 = 1 ; V4 = 0),

    TotalScore is V1 + V2 + V3 + V4,
    TotalScore =:= 3,  % Exactly one hypothesis is false.

    write('--- Solution found ---'), nl,
    format('Antipov (A): ~d~n', [A]),
    format('Borisov (B): ~d~n', [B]),
    format('Tsvetkov (C): ~d~n', [C]),
    format('Dmitriev (D): ~d~n', [D]),
    format('Hypothesis status: [H1:~d, H2:~d, H3:~d, H4:~d]~n', [V1, V2, V3, V4]).

% Search for all solutions.
start :-
    write('Searching for combinations...'), nl,
    findall(_, check_combination(_, _, _, _), _),
    halt.

% Automatic start.
:- initialization(start).
