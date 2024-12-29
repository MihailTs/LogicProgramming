% f е липшицова с константа C, ако за проиизволни x и y
% е в сила |f(X) - f(y)| <= C|x-y|
% isLipschitz(L, C) -> при подаден списък L 
% 					   от двуместни списъци от ест. числа
%					   и ест. число C проверява дали L
%					   e липшицова с константа C

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

abs(X, X) :- X >= 0.
abs(X, Y) :- X < 0 , Y is -X.

isLip(L, C) :- not((member([A, Fa], L), member([B, Fb], L),
				    DiffF is Fa - Fb, DiffD is A - B,
                    abs(DiffF, M), abs(DiffD, K), 
                    Mult is C * K, M > Mult)).