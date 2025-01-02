% Да се дефинира на пролог предикат p(L, N), 
% който по подадени списък от естествени числа 
% L и естествено число N проверява, че има N елемента 
% a1...aN на L такива, че за всеки N-1 елемента b1...bN-1 на L 
% е изпълнено, че НОД(a1...aN) != НОД(b1...bN-1).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

subset_N(0, _, []).
subset_N(N, [X|L], [X|R]) :- N >= 1, N1 is N - 1,
    					   subset_N(N1, L, R).
subset_N(N, [_|L], R) :- N >= 1, subset_N(N, L, R).

list_min(L, M) :- member(M, L), not((member(K, L), K < M)).

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

divides_all(_, []).
divides_all(N, [X|L]) :- 0 is X mod N, divides_all(N, L).

gcd([], 1).
gcd([X], X). 
gcd(L, G) :- list_min(L, M), between(1, M, G), divides_all(G, L),
    		 not((between(1, M, G2), divides_all(G2, L), G2 > G)).

p([_|_], 1). 
p(L, N) :- N >= 2, subset_N(N, L, S), gcd(S, G1), N1 is N - 1,  
    	   not((subset_N(N1, L, T), gcd(T, G2), G1 = G2)).



% Казваме, че списък A от числа се поглъща от списък B от числа, 
% ако сборът на всеки два елемента на A се съдържа в B. 
% Да се дефинират на пролог предикатите p(A, B), 
% който по дадени списъци от числа A и B разпознава 
% дали A се поглъща от B, и q(L, S), който по даден списък L 
% от числа генерира в S максимална (по дължина) редица 
% от различни елементи на L, за която е вярно, 
% че всеки елемент на редицата се поглъща 
% от всички елементи след него в S.

p(A, B) :- not((member(X, A), member(Y, A), 
               	S is X + Y, not(member(S, B)))).

% не е дефинирано елемент да се поглъща от списък







