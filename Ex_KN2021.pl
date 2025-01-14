% Казваме, че списък от списъци L е ламиниран, ако всеки два списъка от L 
% или нямат общи елементи, или всички елементи на единия 
% са елементи на другия. Да се дефинира на пролог предикат is_laminar(L), 
% който по даден списък от списъци L проверява дали L е ламиниран.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

insert(X, L, [X|L]).
insert(X, [H|L], [H|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

is_laminar(L) :- not((member(A, L), member(B, L),
                      (member(X, A), member(X, B)),
                      not(permutation(A, B))
                    )).


% Дефинирайте предикат на пролог save_Christmas(N, M, K, L), 
% който генерира всички възможни списъци L от K правоъгълни размери 
% (дължина, ширина), които могат да се изрежат от картон с размер N x M, 
% използвайки само вертикални и хоризонтални разрези.

append([], L, L).
append([H|L], T, [H|R]) :- append(L, T, R).

remove_similar([], []).
remove_similar([H|L], [H|R]) :- remove_similar(L, R), 
    							not((member(A, L), permutation(A, H))).
remove_similar([H|L], R) :- remove_similar(L, R), 
    						member(A, L), permutation(A, H).

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

first_cut_horizontal(N, M, 1, [[[N,M]]]).
first_cut_horizontal(_, 1, _, [[]]).
first_cut_horizontal(N, M, K, L) :- M > 1, M1 is M - 1,
    								between(1, M1, C),
                                    M2 is M - C,
    								K1 is K - 1,
    								between(1, K1, Kcnt),
    								save_christmas(N, C, Kcnt, L1),
    								K2 is K - K1,
    								save_christmas(N, M2, K - Kcnt, L2),
    								append(L1, L2, L).

first_cut_vertical(N, M, 1, [[[N,M]]]).
first_cut_vertical(1, _, _, [[]]).
first_cut_vertical(N, M, K, L) :- N > 1, N1 is N - 1,
    							  between(1, N1, C),
                                  N2 is N - C,
    							  K1 is K - 1,
    							  between(1, K1, Kcnt),
    							  save_christmas(C, M, Kcnt, L1),
    							  K2 is K - K1,
    							  save_christmas(N2, M, K - Kcnt, L2),
    							  append(L1, L2, L).


save_christmas(1, 1, 1, [[1,1]]).
save_christmas(N, M, K, L) :- first_cut_horizontal(N, M, K, L1),
    						  first_cut_vertical(N, M, K, L2),
    						  append(L1, L2, Lpr),
    						  remove_similar(Lpr, L).