% Да се дефинира предикат p(L, N), който по даден списък 
% от положителни цели числа L и положително цяло число N 
% разпознава дали N може да се представи като произведение 
% на няколко (не непременно различни) елемента на L.

subset([], []).
subset([X|L], [X|R]) :- subset(L, R).
subset([_|L], R) :- subset(L, R).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

product([X], X).
product([X|L], N) :- product(L, N1), N is N1 * X.

p(L, X) :- member(X, L).
p(L, N) :- member(X, L), X \= 1, 0 is N mod X, N1 is N div X, p(L, N1).


% Списък от три числа [X, Y, R] ще интерпретираме като окръжност 
% с център <X, Y> и радиус R. Да се дефинира генератор 
% circles(X, Y, R, Z, T, S), който по дадена окръжност 
% [X, Y, R] при преудовлетворяване генерира в Z, T и S окръжности, 
% които съдържат окръжността [X, Y, R]

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

sign(-1).
sign(1).

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

nat_tri(X, Y, Z) :- nat(K), sign(Sx), sign(Sy), between(0, K, X1),
    				K1 is K - X1, between(0, K1, Y1),
    				Z is K1 - Y1,
    				X is Sx * X1, Y is Sy * Y1.

circles(X, Y, R, Z, T, S) :- nat_tri(Z, T, S),
    						 Z - S =< X - R,
    						 Z + S >= X + R,
    						 T - S =< Y - R,
    						 T + S >= Y + R.       