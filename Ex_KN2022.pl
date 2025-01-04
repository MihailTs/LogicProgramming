% https://github.com/YanaRGeorgieva/Logic-programming/blob/master/%D0%98%D0%B7%D0%BF%D0%B8%D1%82%D0%B8%20%D0%BE%D1%82%20%D0%BC%D0%B8%D0%BD%D0%B0%D0%BB%D0%B8%20%D0%B3%D0%BE%D0%B4%D0%B8%D0%BD%D0%B8/%D0%9F%D0%B8%D1%81%D0%BC%D0%B5%D0%BD%D0%B8%20%D0%B8%D0%B7%D0%BF%D0%B8%D1%82%D0%B8/%D0%9F%D0%B8%D1%81%D0%BC%D0%B5%D0%BD%20%D0%B8%D0%B7%D0%BF%D0%B8%D1%82%20%D0%9A%D0%9D%202021-2022/LogProg-KN-2022janvier-e2-final1.pdf

% problem 1

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

append([], L, L).
append([H|T], L, [H|R]) :- append(T, L, R).

vertices([[A,B]|E], [A,B|V]) :- vertices(E, V),
    							not(member(A, V)), not(member(B,V)).
vertices([[A,B]|E], [A|V]) :- vertices(E, V),
    						  not(member(A, V)), member(B,V).
vertices([[A,B]|E], [B|V]) :- vertices(E, V),
    						  member(A, V), not(member(B,V)).
vertices([[A,B]|E], V) :- vertices(E, V),
    					  member(A, V), member(B,V).

neighbors(U, E, [], []).
neighbors(U, E, [X|V], [X|N]) :- neighbors(U, E, V, N),
    							 member([X,U], E).
neighbors(U, E, [X|V], N) :- neighbors(U, E, V, N),
    						 not(member([X,U], E)).

take(_, 0, []).
take(V, K, [X|T]) :- K > 0, member(X, V), K1 is K - 1, take(V, K1, T).

is_path([], _).
is_path([_], _).
is_path([[X,Y]|P], E) :- X \= Y, member([X,Y], E), is_path([Y|P], E).

K_path(X, Y, K, E, V) :- K1 is K - 1, take(V, K1, P),
    					 append([X|P], [Y], P1),
    					 is_path(P1, E).

pc_Gr(E, K) :- vertices(E, V), 
    		   not((member(X, V), neighbors(X, E, V, N),
                    member(Y, N), not(K_path(X, Y, K, E, V))
                  )).

% problem 2

divide([], [], []).
divide([X|L], [X|L1], L2) :- divide(L, L1, L2).
divide([X|L], L1, [X|L2]) :- divide(L, L1, L2).

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

crush(0, []).
crush(N, [X|M]) :- between(1, N, X), N1 is N - X,
    			   crush(N1, M).

sum([], 0).
sum([X|L], S) :- sum(L, S1), S is S1 + X.

equPart(N, L) :- crush(N, L), divide(L, A, B),
    			 sum(A, Sa), sum(B, Sb), Sa = Sb.
        
        
        