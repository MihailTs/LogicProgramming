% Ще казваме, че един списък е анаграма на друг, 
% ако е съставен от същите елементи, но в евентуално различен ред.
% Да се дефинира предикат на пролог maxAnagrams(L, M) на пролог, 
% който по даден списък от списъци L, генерира в M най-голямото число, 
% за което има поне M на брой:
% M-елементни списъка от L, които са анаграми един на друг.
% (M + 2)-елементни списъка от L, които са анаграми един на друг.

append([], X, X).
append([H|T], L, [H|R]) :- append(T, L, R).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

% permutation(X, Y) - X е пермутация на Y
permutation([], []).
permutation([X], [X]).
permutation([H|T], R) :- permutation(T, T1),
    					 append(L1, L2, T1),
    					 permutation(L1, P1),
    					 permutation(L2, P2),
    					 append(P1, [H|P2], R).

% are_all_anagrams(L) проверява дали всички списъци в L
% са анаграми (пермутации) един на друг
are_all_anagrams([]).
are_all_anagrams([_]).
are_all_anagrams([X,Y|R]) :- permutation(X, Y),
    						 are_all_anagrams([Y|R]).

% length_N(L, N) е истина, ако дължината на L е N
length_N([], 0).
length_N([_], 1).
length_N([_|L], N) :- length_N(L, N1), N is N1 + 1.

% all_length_N(L, N, All) при подаден списък от списъци L
% и ест. число N генерира в All всички списъци от L,
% които имат дължина N
% all_length_N(L, 0, [[]]) :- member([], L).
all_length_N([], _, []).
all_length_N([X|L], N, [X|M]) :- length_N(X, N),
    							 all_length_N(L, N, M).
all_length_N([X|L], N, M) :- not(length_N(X, N)), all_length_N(L, N, M).

maxAnagrams(L, M) :- M2 is M + 2, 
    				 all_length_N(L, M2, L1),
    				 length_N(L1, M),
    				 are_all_anagrams(L1),
    				 all_length_N(L, M, L2),
					 length_N(L2, M),
    				 are_all_anagrams(L2).
					 % проверка че няма по-голямо такова M

