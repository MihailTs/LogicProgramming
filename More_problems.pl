% Да се дефинира на Пролог предикат p(X, Y), 
% който по даден списък от числа X при преудовлетворяване 
% дава в Y всички разделяния на X. Разделяне на X е такъв списък 
% [X1, X2, ..., Xn], че конкатенацията на списъците X1, X2, ..., Xn е X.

append([], X, X).
append([H|L], T, [H|R]) :- append(L, T, R).

prefix(L, P) :- append(P, _, L).

p([], []).
p(X, [A|Y]) :- append(A, B, X), A \= [], p(B, Y).

% Да се дефинира на Пролог двуместен предикат p, 
% който по даден списък от списъци L генерира в M 
% най-дългата обща подредица на елементите на L.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

subsequence([], []).
subsequence([X|L], [X|R]) :- subsequence(L, R).
subsequence([_|L], R) :- subsequence(L, R).

larger_than([_|_], []).
larger_than([_|L], [_|T]) :- larger_than(L, T).

lcs([], []).
lcs(L, Lcs) :- member(X, L), subsequence(X, Lcs), 
    		   not((member(A, L), not(subsequence(A, Lcs)))),
    		   not((subsequence(X, LCS1), LCS1 \= Lcs, 
                    not((member(A, L), not(subsequence(A, LCS1)))),
                    larger_than(LCS1, Lcs))).

% Нека L е списък от списъци, L = [L1, L2, ..., Ln]. 
% Казваме, че списъкът M е подредица на L, 
% ако M = [L_i1, L_i2, ..., L_ik], където 1 ≤ ij ≤ n за j = 1, ..., k 
% и i1 < i2 < ... < ik. Да се дефинира на Пролог едноместен предикат p, 
% който по даден списък от списъци L разпознава 
% дали има такава подредица M на L, че 
% конкатенацията на елементите на M да е елемент на L.

flatten([], []).
flatten([X|L], F) :- flatten(L, F1), append(X, F1, F).

p1(L) :- subsequence(L, M), flatten(M, Mf1), 
        flatten(Mf1, Mf2), member(Mf2, L).


% Нека L е списък, който има следния вид: 
% [[x1, y1], [x2, y2], ..., [xn, yn]]. Ще казваме, 
% че L представлява бинарната релация R, 
% ако R = {(x1, y1), (x2, y2), ..., (xn, yn)}. 
% Да се дефинира на Пролог:
% а) едноместен предикат s, който по даден списък L, 
%    представляващ бинарната релация R, 
%    разпознава дали R е симетрична релация.
% б) едноместен предикат t, който по даден списък L, 
%    представляващ бинарната релация R, 
%    разпознава дали R е транзитивна релация.
% в) триместен предикат c, който по дадени два списъка L1 и L2, 
%    представляващи съответно бинарните релации R1 и R2, 
%    генерира в L3 списък, представляващ композицията R3 на R1 и R2.
% Напомняне: (x, z) принадлежи на R3 тогава и само тогава, 
% когато има двойки (x, y) и (y, z), 
% такива че (x, y) принадлежи на R1 и (y, z) принадлежи на R2.

domain([], []).
domain([[X,_]|L], [X|D]) :- domain(L, D), not(member(X, D)).
domain([[X,_]|L], D) :- domain(L, D), member(X, D).

symmetric(L) :- not((member([A,B], L), not(member([B,A], L)))).

transitive(L) :- domain(L, D),
    			 not((member(A, D), member(B, D), member(C, D),
                      A \= B, A \= C, B \= C,
                      member([A,B], L), member([B,C], L), not(member([A,C], L))
                    )).

compose_help(_, [], []).
compose_help([A,C], [[C,D]|L], [[A,D]|R]) :- compose_help([A,C], L, R).
compose_help([A,B], [[C,_]|L], R) :- B \= C, compose_help([A,B], L, R).

c([], _, []).
c([X|L1], L2, [Xc|L3]) :- compose_help(X, L2, Xc), c(L1, L2, L3).


% Нека L е списък от списъци, L = [L1, L2, ..., Ln]. 
% Казваме, че двойката от списъци F и G е разбиение на L, 
% ако F = [i1, i2, ..., ik] и G = [j1, j2, ..., jn-k], 
% където {i1, i2, ..., ik, j1, j2, ..., jn-k} = {1, 2, ..., n}. 
% Обединение на списък от списъци е множеството на всички обекти, 
% които са елементи на някой елемент на списъка. 
% Да се дефинира на Пролог едноместен предикат p, 
% който по даден списък от списъци L разпознава 
% дали L може да се разбие на два списъка, които имат едно и също обединение.

insert(X, [], [X]).
insert(X, L, [X|L]).
insert(X, [H|L], [H|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

break([], [], []).
break([X|L], [X|A], B) :- break(L, A, B).
break([X|L], A, [X|B]) :- break(L, A, B).

p2(L) :- break(L, A, B), flatten(A, Af), flatten(B, Bf),
		permutation(Af, P), permutation(Bf, P).        


% Да се дефинира на Пролог предикат p, 
% който по даден списък от списъци L разпознава 
% дали L може да се сортира по отношението <_ (подмножество). 
% Ако l1 и l2 са списъци, l1 <_ l2 означава, 
% че елементите на l1 са елементи на l2, 
% но не всички елементи на l2 са елементи на l1. 
% Внимание: [[0], [1]] не може да се сортира по <_.

subset(L, S) :- subsequence(L, S1), permutation(S1, S).

is_sorted_acc_subset([]).
is_sorted_acc_subset([_]).
is_sorted_acc_subset([A,B|L]) :- subset(B, A), 
    							 is_sorted_acc_subset([B|L]).

p3(L) :- permutation(L, P),
    	 is_sorted_acc_subset(P).

% Ако n е естествено число с десетичен запис c1c2...ck, 
% негатив на n наричаме числото с десетичен запис d1d2...dk, 
% където di = 9 - ci за i = 1, 2, ..., k. 
% Да се напише предикат на Пролог, който генерира 
% всички естествени числа, чийто негатив е просто число.
% Пример: Негативът на числото 992 е 007, т.е. 7.

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

num_to_list(N, [N]) :- N >= 0, N < 10.
num_to_list(N, Nlist) :- N >= 10, N1 is N div 10, 
    					 M is N mod 10,
    					 num_to_list(N1, N1list),
    					 append(N1list, [M], Nlist).

get_negativ([X], [Y]) :- Y is 9 - X.
get_negativ([X|Nlist], [Y|NNlist]) :- Y is 9 - X, get_negativ(Nlist, NNlist).

list_length([], 0).
list_length([_|L], N) :- list_length(L, N1), N is N1 + 1.

list_to_num([X], X) :- X >= 0, X < 10.
list_to_num([X|L], N) :- list_to_num(L, N1), list_length(L, Ll),
    					 N is (10 ^ Ll) * X + N1.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

is_prime(N) :- N > 1, N1 is N - 1, 
    		   not((between(2, N1, K), 0 is N mod K)).

number_negativ(N) :- nat(N), num_to_list(N, Nlist),
    				 get_negativ(Nlist, NNlist),
    				 list_to_num(NNlist, NN),
    				 is_prime(NN).
    				 

% Да се дефинира на Пролог предикат t(M, T), 
% който по дадена матрица M генерира в T транспонираната ѝ матрица. 
% Матрица представяме като списък от редове, 
% всеки от които е списък от елементите на този ред.

list_of_heads([], []).
list_of_heads([[H|_]|L], [H|R]) :- list_of_heads(L, R).

remove_heads([], []).
remove_heads([[_|T]|L], [T|R]) :- remove_heads(L, R).

empty_lists([]).
empty_lists([[]|L]) :- empty_lists(L).

t(M, []) :- empty_lists(M).
t(M, [Fs|T]) :- list_of_heads(M, Fs), 
    		    remove_heads(M, M1),
    			t(M1, T).    