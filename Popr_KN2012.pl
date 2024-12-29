% Нека L е списък от списъци, L = [l1, l2, ..., ln]. 
% Казваме, че двойката от списъци F и G е разбиване на L, 
% ако F = [li1, li2, ..., lik] и G = [lj1, lj2, ..., ljn-k], 
% където {i1, i2, ..., ik, j1, j2, ..., jn-k} = {1, 2, ..., n}.
% Обединение на списък от списъци е множеството на всички обекти, 
% които са елементи на някой елемент на списъка.
% Да се дефинира на Пролог едноместен предикат p, 
% който по даден списък от списъци L разпознава 
% дали L може да се разбие на два списъка, 
% които имат едно и също обединение.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

append([], X, X).
append([H|T], L, [H|R]) :- append(T, L, R).

insert(X, L, [X|L]).
insert(X, [Y|L], [Y|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, Lp),
    					 insert(X, Lp, P).

union_of_list([], []).
union_of_list([X|L], U) :- union_of_list(L, Ul), append(Ul, X, U).

equal_lists([], []).
equal_lists([X|L], [X|R]) :- equal_lists(L, R).

p(L) :- permutation(L, P), append(U, V, P), 
    	union_of_list(U, Uu), union_of_list(V, Uv),
    	permutation(Uu, Perm), equal_lists(Perm, Uv).


% Да се дефинира на Пролог едноместен предикат p, 
% който при презадоволяване генерира всички списъци 
% [X1, Y1, X2, Y2, X3, Y3], такива че 
% X1, Y1, X2, Y2, X3, Y3 са цели числа, 
% които са върхове на правоъгълен триъгълник с върхове, 
% точките с координати (X1; Y1), (X2; Y2) и (X3; Y3), 
% като правият ъгъл е при върха с координати (X1, Y1).

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

between(A, A, A).
between(A, B, A) :- B > A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

ordered_six(X1, Y1, X2, Y2, X3, Y3) :- 
    			nat(K1), between(0, K1, X1),
    			K2 is K1 - X1, between(0, K2, Y1),
    			K3 is K2 - Y1, between(0, K3, X2),
    			K4 is K3 - X2, between(0, K4, Y2),
    			K5 is K4 - Y2, between(0, K5, X3),
    			Y3 is K5 - X3.

p(X1, Y1, X2, Y2, X3, Y3) :- ordered_six(X1, Y1, X2, Y2, X3, Y3),
 				 L1 is (X2 - X1) * (X2 - X1) + (Y2 - Y1) * (Y2 - Y1),
    			 L2 is (X3 - X1) * (X3 - X1) + (Y3 - Y1) * (Y3 - Y1),
    			 L1 + L2 =:= (X3 - X2) * (X3 - X2) + (Y3 - Y2) * (Y3 - Y2).
    
    
    
    
