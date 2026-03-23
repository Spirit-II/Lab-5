% Сумма цифр числа.
sum_digits(0, 0) :- !.
sum_digits(N, Sum) :-
    PositiveN is abs(N),
    sum_digits_positive(PositiveN, Sum).

sum_digits_positive(0, 0) :- !.
sum_digits_positive(N, Sum) :-
    Digit is N mod 10,
    NextN is N // 10,
    sum_digits_positive(NextN, SubSum),
    Sum is SubSum + Digit.

% Подсчёт количества вычитаний суммы цифр до нуля.
subtract_sum_until_zero(N, Steps) :-
    N =:= 0 -> Steps = 0 ;
    sum_digits(N, Sum),
    NextN is N - Sum,
    subtract_sum_until_zero(NextN, SubSteps),
    Steps is SubSteps + 1.

% Ввод числа с обработкой ошибок.
get_number(N) :-
    catch(read(X), _, fail),
    (   number(X) -> N = X
    ;   write('Error: Invalid input (not a number or missing dot).'), nl, fail
    ).

% Основная функция.
start :-
    write('Enter a natural number (Example: 123.):\n'),
    (   get_number(N) ->
        subtract_sum_until_zero(N, Steps),
        nl,
        format('Number: ~w~n', [N]),
        format('Steps to zero: ~d~n', [Steps])
    ;
        write('Program stopped due to invalid input.'), nl
    ),
    halt.

% Автоматический запуск.
:- initialization(start).
