% Казваме, че списък X мажорира списък Y, ако всички елементи на X
% са елементи на Y. Да се дефинира на пролог предикат p(L, M), 
% който по даден списък от списъци L намира списък M, 
% който съдържа всички елементи на L и в който
% никой елемент не се мажорира от елемент, 
% намиращ се след него в списъка.

% member(X, L) проверява дали X е елемент на L
member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

% append(L, T, R) при подадени списъце L и T генерира в R конкатенацията L.T
append([], X, X).
append([H|L], T, [H|R]) :- append(L, T, R).

% majorate(X, Y) проверява дали X мажорира Y
majorate([], _).
makorate([H|T], Y) :- member(H, Y), majorate(T, Y).

% permutation(L, P) при преудовл. генерира в P пермутация на L
permutation([], []).
permutation([X], [X]).
permutation([H|L], P) :- permutation(L, Lp),
    					 append(L1, L2, Lp),
    					 append(L1, [H|L2], P).
    
% is_ordered(L) при подаден списък от списъци L проверява
% дали L е нареден относно релацията мажориране
is_ordered([]).
is_ordered([X]).
is_ordered([X|T]) :- not((member(Y,T), majorate(Y, X))), is_ordered(T).

p(L, M) :- permutation(L, M), is_ordered(M).
    