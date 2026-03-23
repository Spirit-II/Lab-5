% Проверка принадлежности элемента списку.
is_member(X, [X|_]) :- !.
is_member(X, [_|T]) :- is_member(X, T).

% Создание множества (удаление дубликатов).
make_set([], []).
make_set([H|T], Result) :-
    is_member(H, T),
    !,
    make_set(T, Result).
make_set([H|T], [H|Result]) :-
    make_set(T, Result).

% Нахождение пересечения множеств (ручками).
intersection_sets(Set1, Set2, Intersection) :-
    make_set(Set1, CleanSet1),
    make_set(Set2, CleanSet2),
    findall(X, (member(X, CleanSet1), member(X, CleanSet2)), Intersection).

% Ввод списка пользователем.
get_list(List, Name) :-
    format('Enter ~w (Example: [1, 2, 1].): ', [Name]), nl,
    catch(read(S), _, S = error_flag),
    (   is_list(S) -> List = S
    ;   write('Error: This is not a list!\n'), fail
    ).

% Основной предикат.
start :-
    (   get_list(L1, 'first list'),
        get_list(L2, 'second list') ->
        intersection_sets(L1, L2, Result),

        nl,
        write('--- Results ---\n'),
        format('Source List 1: ~w~n', [L1]),
        format('Source List 2: ~w~n', [L2]),
        format('Intersection:   ~w~n', [Result])
    ;
        nl, write('Calculation aborted due to input error.\n')
    ),
    halt.

% Автоматический запуск.
:- initialization(start).
