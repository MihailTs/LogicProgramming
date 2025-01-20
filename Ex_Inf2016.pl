% Да се дефинира на пролог предикат p(L), който по даден списък L 
% от списъци проверява дали за всеки два елемента на L, 
% съществува трети елемент, съдържащ всички общи елементи на другите два.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

p(L) :- not((member(A, L), member(B, L), A \= B,
             member(C, L), C \= A, C \= B,
             not((member(M, A), member(M, B), not(member(M, C))))
           )).


% Един списък от числа е базов, ако всеки два различни негови елементи 
% са взаимно прости. Да се реализират на пролог следните предикати:
% base(L), който разпознава дали даден списък L е базов;
% gen(M,L), който по даден списък M от числа генерира в L 
%   всички базови списъци, чиито елементи са елементи на M;
% max(M,L), който по даден списък от числа M генерира в L 
%   всички базови списъци, чиито елементи са елементи и на M, 
%   и които не се съдържат в по-големи базови списъци, 
%   чиито елементи са елементи и на M.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

coprime(X, Y) :- not((between(2, X, M), 0 is A mod M, 0 is B mod M)).

subsequence([], []).
subsequence([X|L], [X|R]) :- subsequence(L, R).

insert(X, L, [X|L]).
insert(X, [H|L], [H|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

subset(L, S) :- subsequence(L, S1), permutation(S1, S).

has_duplicates([X|L]) :- member(X, L).
has_duplicates([X|L]) :- not(member(X, L)), has_duplicates(L).

list_length([], 0).
list_length([_|L], N) :- list_length(L, N1), N is N1 + 1.

base(L) :- not((has_duplicates(L), member(A, L), 
                member(B, L), not(coprime(A, B))
              )).

gen(M, L) :- subset(M, L), base(L).

max(M, L) :- subset(M, L), base(L), list_length(L, N),
    		 not((subset(M, L1), base(L1), 
                  list_length(L1, N1),
                  subset(L1, L), N1 > N
                )).