nat(0).
nat(N) :- nat(N1), N is N1 + 1.

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

%при подаден граф X генерира във V достижимите върхове на X
vertices([], []).
vertices([[X,_,X]|R], [X|V]) :- vertices(R, V),
    							  not(member(X, V)).
vertices([[X,_,Y]|R], [X,Y|V]) :- vertices(R, V), X \= Y,
    							  not(member(X, V)), not(member(Y, V)).
vertices([[X,_,Y]|R], [X|V]) :- vertices(R, V),
    							  not(member(X, V)), member(Y, V).
vertices([[X,_,Y]|R], [Y|V]) :- vertices(R, V),
    							  member(X, V), not(member(Y, V)).
vertices([[X,_,Y]|R], V) :- vertices(R, V),
    							  member(X, V), member(Y, V).

% path(X, P) - приема граф като списък на ребрата и генерира път от X в P
path(X, [Y,E,Z]) :- member([Y,E,Z], X).
path(X, [Y,Е,Z|P]) :- member([Y,Е,Z], X), path(X, [Z|P]).

cop(X, 1, Y, R) :- R is X - Y.
cop(X, 2, Y, R) :- R is X * Y.
cop(X, 3, Y, R) :- R is X mod Y.
cop(X, 4, Y, R) :- R is X + Y.

calc_path(S, [X,E,Y]) :- cop(X, E, Y, S).
calc_path(S, [X, E, Y | T]) :- cop(X, E, Y, R), calc_path(S, [R|T]).

p(K, X) :- path(X, P), calc_path(K, P).
    
    
    