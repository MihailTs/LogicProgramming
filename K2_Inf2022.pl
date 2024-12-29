% Разглеждаме крайни множества от крайни затворени интервали от реални числа 
% с непрaзна вътрешност, чиито краища са цели числа. 
% Нека A е едно такова множество. Казваме, че A е нормално, 
% ако всеки два различни негови елемента имат празно сечение; 
% обединението на елементите на A ще наричаме обем на A. 
% Представяне на A е списък ℓ₁, ℓ₂, ..., ℓₙ, където n е броят на елементите на A, 
% ℓᵢ за 1 ≤ i ≤ n е двуелементен списък [aᵢ, bᵢ] от цели числа, aᵢ ≤ bᵢ и {x ∈ R | aᵢ ≤ x ≤ bᵢ} ∈ A.

% Да се дефинира на пролог двуместен предикат normalize_c(L, X), 
% който по даден списък L, представящ множество A от интервали от разглеждания вид, 
% генерира в X списък, представящ нормално множество B от интервали, 
% което има същия обем като A.

append([], X, X).
append([H|L], T, [H|R]) :- append(L, T, R).

permutation([], []).
permutation([X], [X]).
permutation([H|L], P) :- permutation(L, P1),
    					 append(X, Y, P1),
    					 append(X, [H|Y], P).

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

% divide(I, X) - при I списък, представящ интервал от вида [a,b],
% където a < b, генерира в X списък от крайни затворени интервали,
% от естествени числа, чието обединение е I

divide([A, B], [[A, B]]) :- B > A.
divide([A, B], X) :- B > A + 2, nat(M), M < B, M > A,
    				 M1 is M + 1, divide([M1, B], R), 
    				 append([[A, M]], R, X).

normalize_c([], []).
normalize_c([H|L], X) :- normalize_c(L, X1),
    					 divide(H, D), 
    					 append(D, X1, P),
						 permutation(P, X).


gcd(A, B, Q) :- A mod Q =:= 0,
    			B mod Q =:= 0,
                not((nat(P), P < A, P > Q, A mod P =:= 0, B mod P =:= 0)).




