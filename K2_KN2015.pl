% За произволен списък [a1, a2, ..., ak] ще казваме, 
% че списъците от вида [am, am+1, ..., am+i], 
% където 1 ≤ m ≤ k и 0 ≤ i ≤ k - m, са негови подсписъци. 
% Да се дефинира предикат p(X, Y, Z), който по дадени списъци X и Y 
% генерира всички подсписъци Z на Y, 
% такива че дължината на Z е колкото дължината на X, 
% всеки елемент на Z е по-голям от елемента, 
% намиращ се на същата позиция в X и последните елементи на Z и Y са равни.

append([], X, X).
append([X|L], T, [X|R]) :- append(L, T, R).

llength([], 0).
llength([_|L], N) :- llength(L, N1), N is N1 + 1. 

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

ordered_N([], 0).
ordered_N(L, N) :- nat(K), ordered_N_help(L, N, K).

ordered_N_help([X], 1, X).
ordered_N_help([X|L], N, K) :- N1 is N - 1, nat(K1), ordered_N_help(L, N1, K1), 
    						   K is K1 + X, between(0, K, X).

% p(X, Y, Z) :- llength(X, Lx), llength(Y Ly),
%     		  Ld is Lx - Ly, ordered_N(D, Ld),
%     		  append(D, Y, Z), greater(Z, X).
    		  %,

% Да се дефинира предикат p(X, Y), 
% който по даден списък X генерира в Y всички списъци, 
% чиито елементи са елементи на X и броят на срещанията на 
% най-често срещания елемент в Y е число, което не е елемент на X.

subset([], []).
subset([X|L], [X|R]) :- subset(L, R).
subset([X|L], R) :- subset(L, R).

insert(X, [], [X]).
insert(X, L, [X|L]).
insert(X, [H|L], [H|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

count(_, [], 0).
count(X, [H|L], N) :- X \= H, count(X, L, N). 
count(X, [X|L], N) :- count(X, L, N1), N is N1 + 1.

mode(L, X, N) :- member(X, L), count(X, L, N),
    			 not((member(Y, L), X \= Y, count(Y, L, M), M > N)).

p(X, Y) :- subset(X, S), permutation(S, Y), 
    	   mode(Y, _, N), not(member(N, X)).








