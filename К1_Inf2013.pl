% Да се дефинира на пролог предикат p(L), 
% който по даден списък от различни списъци L проверява 
% дали всеки два различни елемента на L имат общ елемент, 
% който не принадлежи на някой елемент на L.

equal([], []).
equal([X|L], [X|R]) :- equal(L, R).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

p(L) :- not((member(X, L), member(Y, L), not(equal(X, Y)),
    		 (not((member(A, X), member(A, Y))) ; 
              (member(A, X), member(A, Y), member(Z, L),
               not(equal(X, Z)), not(equal(Y, Z)), member(A, Z)
              ) 
             )
           )).


% Казваме, че списък X мажорира списък Y, 
% ако всички елементи на X са елементи на Y. 
% Да се дефинира на пролог предикат p(L, M), 
% който по даден списък от списъци L намира списък M, 
% който съдържа всички елементи на L и в който никой елемент 
% не се мажорира от елемент, намиращ се след него в списъка.

subset([], []).
subset([X|L], [X|R]) :- subset(L, R).
subset([_|L], R) :- subset(L, R).

insert(X, L, [X|L]).
insert(X, [Y|L], [Y|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

% unordered subset
majorates(X, Y) :- permutation(X, X1), subset(Y, X1).

ord_major([]).
ord_major([_]).
ord_major([X,Y|M]) :- not(majorates(X, Y)), ord_major([Y|M]).

p(L, M) :- permutation(L, M), ord_major(M).
       
       
      
       




