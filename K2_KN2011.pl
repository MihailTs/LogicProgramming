% Нека E е списък от двойки елементи. Графът G(E) е ориентиран граф, 
% в който няма изолирани върхове, и между два върха u и v има ребро
% точно тогава, когато [u, v] е елемент на списъка E.
% Да се дефинира предикат на Пролог p(E, v), който, 
% подаден със списък от двойки E и връх v от графа G(E), 
% проверява дали в G(E) съществува цикъл, който преминава през v.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

remove_duplicates([], []).
remove_duplicates([H|L], [H|R]) :- not(member(H, L)), remove_duplicates(L, R).
remove_duplicates([H|L], R) :- member(H, L), remove_duplicates(L, R).

vertices_help([], []).
vertices_help([[A, B]|L], [A,B|V]) :- vertices(L, V).

vertices(E, V) :- vertices_help(E, V1), remove_duplicates(V1, V).

permutation([], []).
permutation([X], [X]).
permutation([H|T], R) :- permutation(T, T1), insert(H, T1, R).               

insert(X, [], [X]).
insert(X, [Y|T], [X, Y|T]).
insert(X, [Y|T], [Y|R]) :- insert(X, T, R).

subset(_, []).
subset([H|L], [H|R]) :- subset(L, R).
subset([_|L], R) :- subset(L, R).

remove(_, [], []).
remove(X, [Y|E], [Y|L]) :- not(member(X, Y)), remove(X, E, L).
remove(X, [Y|E], L) :- member(X, Y), remove(X, E, L).

% is_path(P). (nontrivial)
is_path(E, [X,Y]) :- member([X,Y], E) ; member([Y,X], E).
is_path(E, [X,Y|P]) :- (member([X,Y], E) ; member([Y,X], E)),
    				   remove(X, E, Eup), is_path(Eup, [Y|P]).

last([X], X).
last([_,Y|L], M) :- last([Y|L], M).

first([X|_], X).

p(E, Vert) :- vertices(E, V), subset(V, S), permutation(S, Sp),
    		  is_path(E, Sp), first(Sp, Vert), last(Sp, Last), 
    		  (member([Last, Vert], E); member([Vert, Last], E)).
    