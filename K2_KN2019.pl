append(_, X, X).
append([X|L], R, [X|T]) :- append(L, R, T).

remove_duplicates([], []).
remove_duplicates([H|T], [H|R]) :- not(member(H, T)), remove_duplicates(T, R).
remove_duplicates([H|T], R) :- member(H, T), remove_duplicates(T, R).

vertices_help([], []).
vertices_help([[A,B]|X], [A,B|V]) :- vertices_help(X, V).

vertices(X, Y) :- vertices_help(X, Y1), remove_duplicates(Y1, Y).

%subset(K, V, Y) -> K цяло число; V върхове; Y подмн.на V с мощност К
subset(0, _, []).
subset(K, [H|T], [H|S]) :- K > 0, K1 is K - 1, subset(K1, T, S).
subset(K, [_|T], S) :- K > 0, subset(K, T, S).

% https://github.com/YanaRGeorgieva/Logic-programming/blob/master/%D0%98%D0%B7%D0%BF%D0%B8%D1%82%D0%B8%20%D0%BE%D1%82%20%D0%BC%D0%B8%D0%BD%D0%B0%D0%BB%D0%B8%20%D0%B3%D0%BE%D0%B4%D0%B8%D0%BD%D0%B8/%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D0%BD%D0%B8/%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D0%BD%D0%B8%20%D0%9A%D0%9D%202018-2019/%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D0%BD%D0%BE%202/%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D0%BD%D1%821%20(2).jpg
% X представяне на граф без примки чрез списък на ребрата
% [v, v] е от X <-> v e изолиран връх
% cl(K, X) -> K ест. число, X представяне на граф разпознава дали 
%			  X съдържа K-клика (K > 2)

cl(K, X) :- vertices(X, V), subset(K, V, Y), cl_helper(K, X, V, Y).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

% X - списък на ребра; А връх в X; Y върхове в X, разл. от А
connect([], _, []).
connect(_, _, []).
connect(X, A, [B|Y]) :- (member([A, B], X) ; member([B, A], X)), connect(X, A, Y).

% cl_helper(K, X, V, Y) -> V върховете в графа
% 						   при преудовл. генерира в Y върхове,
% 						   участващи в K-клика 

cl_helper(3, X, V, [A, B, C]) :- member(A, V), member(B, V), member(C, V),
    					 A \= B, B \= C, A \= C,
    					 (member([A, B], X) ; member([B, A], X)),
    					 (member([A, C], X) ; member([C, A], X)),
    					 (member([B, C], X) ; member([C, B], X)).
cl_helper(K, X, V, [A|Y]) :- K > 3, member(A, V), remove_duplicates([A|Y], [A|Y]),
    						 K1 is K-1, cl_helper(K1, X, V, Y),
    						 connect(X, A, Y).
  
    
    
    