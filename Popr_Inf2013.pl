% Нека G е неориентиран граф. Множеството от върховете на G
% е представено със списък V от върховете, 
% всяко ребро e е представено с двуелементен списък на краищата му, 
% а множеството от ребрата на G е представено със списък E от ребрата.
% Да се дефинира на Пролог предикат:
% а) con(V, E), който разпознава дали представеният с V и E граф е свързан.
% б) crit(V, E, X), който по дадени V и E на свързан граф генерира в X
% списък на всички върхове, чието отстраняване води до граф, 
% който не е свързан.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

insert(X, L, [X|L]).
insert(X, [A|L], [A|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

subset([], []).
subset([X|L], [X|R]) :- subset(L, R).
subset([_|L], R) :- subset(L, R).

is_path([_], _).
is_path([X,Y|P], E) :- (member([X,Y], E) ; member([Y,X], E)), is_path([Y|P], E).

starts_with(X, [X|_]).

ends_with(X, [X]).
ends_with(X, [_|L]) :- ends_with(X, L).

are_connected(A, B, V, E) :- member(A, V), member(B, V),
    						 subset(V, S), permutation(S, Ps),
    						 is_path(Ps, E), starts_with(A, Ps),
    						 ends_with(B, Ps).

con(V, E) :- not((member(A, V), member(B, V), not(are_connected(A, B, V, E)))).

remove_vertex(_, [], []).
remove_vertex(X, [X|T], T).
remove_vertex(X, [H|T], [H|R]) :- X \= H, remove_vertex(X, T, R).

remove_edges(_, [], []).
remove_edges(X, [[X,_]|T], R) :- remove_edges(X, T, R).
remove_edges(X, [[_,X]|T], R) :- remove_edges(X, T, R).
remove_edges(X, [H|T], [H|R]) :- H = [A,B], A \= X, 
    							 B \= X, remove_edges(X, T, R).

is_critical(X, V, E) :-
    remove_vertex(X, V, V1),
    remove_edges(X, E, E1),
    not(con(V1, E1)).

crit(V, E, X) :-
    findall(Vertex, (member(Vertex, V), is_critical(Vertex, V, E)), X).


% Редицата a0, a1, a2, a3,... е дефинирана рекурентно така:
% a0 = 1, an+1 = 2an + 1.
% Да се дефинира на Пролог предикат p(N), 
% който по дадено число N разпознава дали N може да се представи 
% като сума на два елемента на редицата a0, a1, a2, a3, ...

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

a(X) :- between(1,X,Y), X is 2 ^ Y - 1.

between_a(A, A, A) :- a(A).
between_a(A, B, A) :- B >= A, a(A).
between_a(A, B, X) :- B > A, A1 is A + 1, between_a(A1, B, X).

p(N) :- between_a(0, N, X), between_a(0, N, Y), N is X + Y.








