% Списък X от списъци се нарича кохерентен, 
% ако всеки елемент на X (освен последния) 
% има общ елемент със следващия елемент на X. 
% Да се дефинира на Пролог предикат p(X), 
% който по даден списък X от списъци проверява дали X е кохерентен.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

p2([_]).
p2([X,Y|R]) :- member(A, X), member(A, Y), p2([Y|R]).
