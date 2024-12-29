% Да се дефинира на пролог предикат p(XY),
% който по даден списък от числа X и списък от списъци
% от числа Y проверява дали са изпълнени следните три
% условия: 1) X може да се представи като конкатенация
% на два елемента на Y; 2) X има четен брой елементи
% и 3) сумата от елементите на X е последен елемент на
% елемент на Y.

append([], X, X).
append([H|L], T, [H|R]) :- append(L, T, R).

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

length_list([], 0).
length_list([_|L], N) :- length_list(L, N1), N is N1+1.

sum([], 0).
sum([X|L], N) :- sum(L, N1), N is N1 + X.

last_element([X], X).
last_element([_|L], M) :- last_element(L, M).

p(X, Y) :- member(A, Y), member(B, Y), append(A, B, X),
    	   length_list(X, N), N mod 2 =:= 0,
    	   sum(X, S), member(C, Y), last_element(C, S).
    	   
    	   

% Да се дефинира на пролог предикат
% p(XYK), който по даден списък от двуелементни списъци 
% от естествени числа K генерира в X и Y всички
% двойки от естествени числа, за които е изпълнено поне
% едно от следните три условия: 1) [X+100, Y-1] е елемент
% на K; 2) съществуват такива елементи [X1 Y1] и [X2 Y2]
% на K, че X =X1+X2 и Y =Y1*Y2 или 3) [X*(Y^2),(X^2)*Y] е
% елемент на K.

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

cartesian_product(X, Y) :- nat(K), cartesian_helper(K, X, Y).

cartesian_helper(K, X, Y) :- between(0, K, X), Y is K - X.

p(X, Y, K) :- (cartesian_product(X, Y), Y > 0,  X1 is X + 100, Y1 is Y - 1,
    		  member([X1, Y1], K)) ; 
    		  (member([A,B], K), member([C,D], K), X is A + C, Y is B * D) ;
    		  (Ysq is Y * Y, Xsq is X * X, P1 is X * Ysq, P2 is Y * Xsq, member([P1, P2], K)).












