% Ще казваме, че списък е кодичен, ако първият му елемент е 0, 
% последният — 1 и всички останали елементи са кодични списъци. 
% Ще казваме, че списък от нули и единици е кодирането 
% на даден кодичен списък, ако може да се получи 
% като изтрием квадратните скоби в записа на кодичния списък. 
% Например списъкът 
% [0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1] 
% е кодирането на кодичния списък 
% [0, [0, [0, 1]], [0, [0, 1], 1], [0, 1], 1]. 
% Да се дефинира предикат q(X, Y), който по дадено кодиране X 
% намира кодичния списък Y, чието кодиране е X.

append([], L, L).
append([H|L], T, [H|R]) :- append(L, T, R).

partition([], []).
partition([X], [[X]]).
partition(L, [X|P]) :- L \= [], append(X, L1, L),
    				   X \= [], partition(L1, P).

q([0,1],[0,1]).
q(X,Y) :- append([0|L], [1], X),
    	  partition(L, P),
    	  q_help(P, Y1),
    	  append([0|Y1], [1], Y).

q_help([],[]).
q_help([X|L], [X1|L1]) :- q(X, X1), q_help(L, L1).


% Ще казваме, че списък от цифри [a1, a2, ..., an] представя числото, 
% което записано в десетична бройна система изглежда a1a2...an. 
% Например списъкът [1, 2, 3] представя числото 123. 
% Да се дефинира предикат p(X, Y, Z), който по дадени списъци от цифри 
% X и Y намира в Z представяне на сбора на числата, 
% представени със списъците X и Y.

list_length([], 0).
list_length([_|L], N) :- list_length(L, N1), N is N1 + 1.

list_to_num([X], X) :- X < 10, X >= 0.
list_to_num([X|L], N) :- list_to_num(L, N1), list_length(L, Len1),
    					 N is (X * 10 ^ Len1 + N1).

num_to_list(N, [N]) :- N < 10, N >= 0.
num_to_list(N, L) :- N >= 10, N1 is N div 10,
    				 num_to_list(N1, L1),
    				 X is N mod 10,
    				 append(L1, [X], L).

p(X, Y, Z) :- list_to_num(X, Xn), list_to_num(Y, Yn),
    		  Zn is Xn + Yn, num_to_list(Zn, Z).
