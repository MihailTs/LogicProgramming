% Да се дефинира на Пролог предикат p(X, Y), 
% който по даден списък X от списъци от числа 
% намира такъв елемент Y на X, че Y не съдържа по-голям елемент
% от най-големите елементи на елементите на X, и никой елемент на X, 
% притежаващ същото свойство, не е с повече елементи от Y.

% най-големият елемент на Y е равен на най-малкия елемент 
% в списъкът от най-големи елементи на елементите на X и Y е най-големият
% по дължина такъв елемент на X

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

list_max([X], X).
list_max([X|L], X) :- list_max(L, M), X >= M.
list_max([X|L], M) :- list_max(L, M), X =< M.

list_min([X], X).
list_min([X|L], X) :- list_min(L, M), X =< M.
list_min([X|L], M) :- list_min(L, M), X >= M.

list_length([], 0).
list_length([_|L], N) :- list_length(L, N1), N is N1 + 1.


% X - списък от списъци, М - списък от най-големите елементи на елем. на X
maxes_list([], []).
maxes_list([A|X], [Maxa|M]) :- list_max(A, Maxa), maxes_list(X, M).

p(X, Y) :- member(Y, X), list_max(Y, M),
    	   maxes_list(X, MaxList), list_min(MaxList, MaxesMin),
    	   M =< MaxesMin, list_length(Y, Len),
    	   not((
               member(Z, X), list_max(Z, M2),
    	       M2 =< MaxesMin, list_length(Z, Len2),
               Len < Len2
               )).



% Да се дефинира на пролог предикат p(A, M/N, K/L), 
% който по дадено естествено число A генерира 
% всички възможни рационални дроби M/N и K/L, такива че:
% N > M > 0,
% K > L > 0,
% (M/N) * (K/L) = 2,
% M + K < A.
            
% НАРЕДЕНИ ЧЕТВОРКИ!!!

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

quadruple(X, Y, Z, U) :- nat(N1), between(0, N1, X), N2 is N1 - X,
    					 between(0, N2, Y), N3 is N2 - Y,
    					 between(0, N3, Z), U is N3 - Z.
    
p(A, [M,N], [K,L]) :- quadruple(M, N, K, L), N > M, M > 0,
    				  K > L, L > 0,
    				  D1 is M * K, D2 is N * L,
    				  D1 is D2 * 2, S is M + K, A > S.