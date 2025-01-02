% Граф G без изолирани върхове ще представяме на пролог 
% посредством списък от всички двуелементни списъци [A, B], 
% където в G има ребро от A до B. Да се дефинира предикат p(G), 
% който по даден ориентиран граф G без изолирани върхове 
% проверява дали върховете на G могат така да се оцветят в два цвята, 
% че никои три ребра да не образуват едноцветен триъгълник.

divide_subsets([], [], []).
divide_subsets([X|L], [X|R], D) :- divide_subsets(L, R, D).
divide_subsets([X|L], R, [X|D]) :- divide_subsets(L, R, D).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

vertices([], []).
vertices([[A,B]|E], [A,B|V]) :- vertices(E, V), not(member(A, V)),
    							not(member(B, V)).
vertices([[A,B]|E], [A|V]) :- vertices(E, V), not(member(A, V)),
    					      member(B, V).
vertices([[A,B]|E], [B|V]) :- vertices(E, V), member(A, V),
    						  not(member(B, V)).
vertices([[A,B]|E], V) :- vertices(E, V), member(A, V),
    					  member(B, V).

p(G) :- vertices(G, V), divide_subsets(V, A, B),
    	not((member(X, [A,B]), 
            member(U, X), member(W, X), member(T, X),
            U \= W, U \= T, W \= T,
            member([U, W], G), member([W, T], G), member([T, U], G)
           )).
    	