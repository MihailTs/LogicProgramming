% Дърво се нарича краен неориентиран свързан и ацикличен граф. 
% За един списък от списъци [V, E] ще казваме, 
% че представлява неориентирания граф G, 
% ако V е списък от всички върхове на G и {v, w} е ребро в G 
% тогава и само тогава, когато [v, w] или [w, v] е елемент на E. 
% Да се дефинира на пролог предикат art_tree(V, E), 
% който по дадено представяне [V, E] на краен неориентиран граф 
% разпознава дали има такава двойка върхове v и w, 
% че [V, E + [v, w]] да е представяне на дърво, 
% където E + [v, w] е списъкът, получен от E с добавянето 
% на нов елемент [v, w].

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

insert(X, L, [X|L]).
insert(X, [H|L], [H|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

subsequence([], []).
subsequence([X|L], [X|R]) :- subsequence(L, R).
subsequence([_|L], R) :- subsequence(L, R).

subset(L, S) :- subsequence(L, S1), permutation(S1, S).

list_last([X], X).
list_last([_|L], X) :- list_last(L, X).

is_path([], _).
is_path([_], _).
is_path([A,B|P], E) :- (member([A,B], E) ; member([B,A], E)),
    				   is_path([B|P], E).

has_path(V, E, A, B) :- subset(V, [A|P]), 
    					list_last([A|P], B),
    					is_path(P, E).

has_cycle(V, E) :- member(A, V), member(B, V),
    			   A \= B, has_path(V, E, A, B),
				   (member([A,B], E) ; member([B,A], E)).

is_tree(V, E) :- not((member(A, V), member(B, V), A \= B,
                      not(has_path(V, E, A, B)))),
    			 not(has_cycle(V, E)).

art_tree(V, E) :- member(U, V), member(W, V),
    			  U \= W, 
				  is_tree(V, [[U,V]|E]).


% Казваме, че списъкът Х е екстерзала за списъка от списъци Ү, 
% ако Х има поне един общ елемент с всички елементи на Y 
% и поне два общи елемента с нечетен брой елементи на У. 
% Да се дефинира на пролог двуместен предикат екстерзала (Х, Ү), 
% който по даден списък от списъци У при презадоволяване генерира 
% всички екстерзали Х за У с възможно най-малка дължина и спира.

append([], L, L).
append([H|L], T, [H|R]) :- append(L, T, R).

flatten([], []).
flatten([X|L], R) :- flatten(L, R1), append(X, R1, R).

remove_duplicates([], []).
remove_duplicates([X|L], [X|R]) :- not(member(X, L)),
    							   remove_duplicates(L, R).
remove_duplicates([X|L], R) :- member(X, L),
    						   remove_duplicates(L, R).

% count_more_than_two_common
cmttc(_, [], 0).
cmttc(X, [A|L], N) :- member(U, X), member(W, X),
      				  U \= W
    				  member(U, A), member(W, A),
    				  cmttc(X, L, N1),  N is N1 + 1.
cmttc(X, [A|L], N) :- not((member(U, X), member(W, X),
      				  	   U \= W
    				  	   member(U, A), member(W, A))),
    				  cmttc(X, L, N).

list_length([], 0).
list_length([X|L], N) :- list_length(L, N1), N is N1 + 1.

exterzala(X, Y) :- flatten(Y, Yfd),
    			   remove_duplicates(Yfd, Yf), 
    			   subsequence(Yf, X),
    			   not((member(A, Y),
                       	not((member(B, X), member(B, A)))
                      )),
				   cmttc(X, Y, N),
    			   1 is N mod 2,
    			   not((subsequence(Yf, X1),
                       	not((member(A, Y),
                       		not((member(B, X1), member(B, A)))
                      	   )),
				   		cmttc(X1, Y, N),
	    			    1 is N mod 2,
                        list_length(X1, N1),
                        list_length(X, N2),
                        N1 < N2
                      )).
