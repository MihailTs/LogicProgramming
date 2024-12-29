% Да се дефинира на Пролог предикат p(L, M), който по даден списък L генерира в M (при преудовлетворяване) всички списъци, които удовлетворяват следните условия:
% Множеството от елементите на M е подмножество на множеството от елементите на L.
% За всеки елемент X от M съществува елемент Y от M, така че следните три числа:
% Разликата на X и Y (X - Y),
% Произведението на X и Y (X * Y),
% Сумата на X и Y (X + Y), са елементи на списъка L.

% subset(L, S) - ��� ������� ������ L �������� � S ������������ �� L
subset([], []).
subset([X|L], [X|S]) :- subset(L, S).
subset([_|L], S) :- subset(L, S).

my_member(H, [H|_]).
my_member(H, [_|T]) :- my_member(H, T).

remove_duplicates([], []).
remove_duplicates([H|L], [H|R]) :- not(my_member(H, L)),
                                   remove_duplicates(L, R).
remove_duplicates([H|L], R) :- my_member(H, L),
                               remove_duplicates(L, R).

dup_subset(L, S) :- remove_duplicates(S, T), subset(L, T).

% member(X, L) - ��� ������� ������ L �������� � X ������ �������� �� L
%                                                        (X �� � ������)

p(_, []).
p(L, M) :-  subset(L, M),
            not(member(X, M), not(member(Y,M),
             A1 is X - Y, A2 is X * Y, A3 is X + Y,
             dup_subset(L, [A1,A2,A3]))).


% Да се дефинира на пролог предикат t(M, T),
% който по дадена матрица M генерира в T транспонираната
% ѝ матрица. Матрица представяме като списък от редове,
% всеки от които е списък от елементите на този ред.

list_of_firsts([], []).
list_of_firsts([[X|_]|M], [X|L]) :- list_of_firsts(M, L).

remove_firsts([], []).
remove_firsts([[_|L]|M], [L|K]) :- remove_firsts(M, K).

empty_lists_list([]).
empty_lists_list([[]|E]) :- empty_lists_list(E).

transpose(E, []) :- empty_lists_list(E).
transpose(M, [X|T]) :- list_of_firsts(M, X), 
    		   		   remove_firsts(M, M1),
    		   		   transpose(M1, T).