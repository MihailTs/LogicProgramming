% а) Да се дефинира на Пролог предикат p(X, A, B), 
% който по даден списък от двойки 
% X = [[a1, b1], [a2, b2], ..., [an, bn]] проверява 
% дали шахматният цар може да се придвижи с един ход 
% от поле с координати [A, B] на поле, 
% чиито координати не са елемент на списъка X.
% б) Да се дефинира предикат q(X), който проверява 
% дали шахматният цар може да се придвижи 
% от поле с координати [1, 1] на поле [8, 8], 
% без да преминава през полета, чиито координати са елемент 
% на списъка X = [[a1, b1], [a2, b2], ..., [an, bn]].
% Забележка: Шахматната дъска е с размер 8 × 8.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

p(X, A, B) :- (A > 1, A1 is A - 1, not(member([A1, B], X)));
    		  (A < 8, A1 is A + 1, not(member([A1, B], X)));
    		  (B > 1, B1 is B - 1, not(member([A, B1], X)));
    		  (B < 8, B1 is B + 1, not(member([A, B1], X))).

can_go(X, A, B, Ato, B) :- Ato >= 1, Ato =< 8, (Ato is A + 1; Ato is A - 1),
    					   not(member([Ato, B], X)).
can_go(X, A, B, A, Bto) :- Bto >= 1, Bto =< 8, (Bto is B + 1; Bto is B - 1),
    					   not(member([A, Bto], X)).

q(X) :- not(member([8,8], X)), q_helper(X,8,8,[]).

% last argument is for visited fields
q_helper(_, 1, 1, _).
q_helper(X, A, B, V) :- A1 is A - 1, not(member([A1, B], V)),
    					can_go(X, A, B, A1, B), q_helper(X, A1, B, [[A1, B]|V]).
q_helper(X, A, B, V) :- A1 is A + 1, not(member([A1, B], V)),
    					can_go(X, A, B, A1, B), q_helper(X, A1, B, [[A1, B]|V]).
q_helper(X, A, B, V) :- B1 is B - 1, not(member([A, B1], V)),
    					can_go(X, A, B, A, B1), q_helper(X, A, B1, [[A, B1]|V]).
q_helper(X, A, B, V) :- B1 is B - 1, not(member([A, B1], V)),
    					can_go(X, A, B, A, B1), q_helper(X, A, B1, [[A, B1]|V]).
    		  
% Да се дефинира на Пролог предикат p(N, L), 
% който по дадено число N и списък от положителни числа L = [a1, a2, ..., an], 
% проверява дали е възможно в редицата a1, a2, ..., an 
% да се вмъкнат по такъв начин символите "(", ")" и "-" , 
% че полученият аритметичен израз да има стойност N.

% УСЛОВИЕТО Е НЕЯСНО












