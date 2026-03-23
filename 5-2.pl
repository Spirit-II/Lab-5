% Проверка, что список упорядочен по возрастанию.
is_sorted([]).          % Пустой список упорядочен.
is_sorted([_]).         % Список из одного элемента упорядочен.
is_sorted([A, B | T]) :- A =< B, is_sorted([B | T]).

% Безопасный ввод с обработкой ошибок.
safe_read(Result) :-
    catch(read(Result), _, Result = error_flag).

% Основной предикат.
start :-
    write('Enter list (Example: [1, 2, 3, 4].):\n'),
    safe_read(List),

    (   List \= error_flag, is_list(List) ->
        (   is_sorted(List) ->
            nl,
            write('--- Result ---\n'),
            write('The list is sorted in ascending order.\n')
        ;
            nl,
            write('--- Result ---\n'),
            write('The list is NOT sorted in ascending order.\n')
        )
    ;
        nl, write('Error: Invalid input format! Check brackets and list elements.\n')
    ),
    halt.

% Автоматический запуск.
:- initialization(start).
