% Да се дефинира предикат p(N, K), който по дадено естествено число N 
% намира в K най-малкия прост делител на N.
% Да се дефинира и предикат q(N, X), който по дадено естествено число N 
% намира в X списък от всички прости делители на N, подредени във възходящ ред.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

is_prime(X) :- X >= 2, X1 is X - 1, not((between(2, X1, K), 0 is X mod K)).  

p(N, K) :- between(1, N, K), 0 is N mod K, is_prime(K), 
    	   not((between(0, N, K1), K1 < K, is_prime(K1), 0 is N mod K1)).

divide(X, Y, X) :- D is X mod Y, D \= 0.
divide(X, Y, Z) :- 0 is X mod Y, X1 is X / Y, divide(X1, Y, Z).

q(N, [N]) :- is_prime(N).
q(N, [D|X]) :- between(2, N, D), 0 is N mod D, p(N, D), divide(N, D, N1), q(N1, X).


% Да се дефинират предикати p(X), q(X) и r(X), 
% такива че ако X е списък от списъци, то:
% p(X) ⇔ два от елементите на някой елемент на X са равни на 5.
% q(X) ⇔ всеки два елемента на X имат поне три различни общи елемента.
% r(X) ⇔ съществува такова ненулево естествено число n, 
% че X съдържа n различни по между си елементи, 
% всеки от които има не повече от 2n елемента.

p_help(_, 0).
p_help([X|L], N) :- X \= 5, p_help(L, N).
p_help([X|L], N) :- X = 5, N1 is N - 1, p_help(L, N1).

p(X) :- memeber(Y, X), p_help(Y, 2).

q(X) :- not((member(A, X), member(B, X),
    		 not((member(U, A), member(U, B),
             member(V, A), member(V, B),
             member(W, A), member(W, B),
    		 U \= V, U \= W, V \= W))
            )).
    
remove_duplicates([], []).
remove_duplicates([X|L], [X|R]) :- not(member(X, L)), remove_duplicates(L, R).
remove_duplicates([X|L], R) :- member(X, L), remove_duplicates(L, R).

list_length([], 0).
list_length([_|L], N) :- list_length(L, N1), N is N1 + 1.

r(X) :- remove_duplicates(X, X1), list_length(X, Lll),
    	list_length(X1, Lx), between(0, Lll, N), Lx >= N,
    	not((member(A, X1), list_length(A, La), Twon is 2 * N, La > Twon)).


