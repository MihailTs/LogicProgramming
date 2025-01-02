% Да се дефинира на пролог предикат p(L), който по даден списък L 
% от списъци проверява дали за всеки два елемента на L 
% съществува трети елемент, 
% съдържащ всички общи елементи на другите два.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

set_intersection([], _, []).
set_intersection([X|A], B, [X|I]) :- member(X, B), 
    								 set_intersection(A, B, I).
set_intersection([X|A], B, I) :- not(member(X, B)), 
    							 set_intersection(A, B, I).

contains_all(_, []).
contains_all(L, [X|T]) :- member(X, L), contains_all(L, T).

p(L) :- not((member(A, L), member(B, L), A \= B,
             not((member(C, L), C \= A, C \= B,
                  set_intersection(A, B, I), contains_all(C, I)
                 ))
            )).


% Един списък от числа е базов, ако всеки два 
% различни негови елементи са взаимно прости. 
% Да се реализират на пролог следните предикати:
% а) base(L), който разпознава дали даден списък L е базов;
% б) gen(M, L), който по даден списък M от числа 
%    генерира в L всички базови списъци, 
%    чиито елементи са елементи на M;
% в) max(M, L), който по даден списък от числа M 
%    генерира в L всички базови списъци, 
%    чиито елементи са елементи и на M 
%    и които не се съдържат в по-големи базови списъци, 
%    чиито елементи са елементи и на M.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

co-prime(A, B) :- A >= B, 
    			  not((between(2, B, X), 0 is A mod X, 0 is B mod X)).
co-prime(A, B) :- B > A, 
    			  not((between(2, A, X), 0 is A mod X, 0 is B mod X)).

subset([], []).
subset([X|A], [X|S]) :- subset(A, S).
subset([_|A], S) :- subset(A, S).

insert(X, [], [X]).
insert(X, A, [X|A]).
insert(X, [Y|A], [Y|B]) :- insert(X, A, B).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

base(L) :- not((member(A, L), member(B, L), 
               	A \= B, not(co-prime(A, B))
              )).

gen(M, L) :- subset(M, S), permutation(S, L), base(L).
    	   
max(M, L) :- subset(M, S), base(S),
    		 not((subset(M, S1), S1 \= S, base(S1), subset(S1, S))),
			 permutation(S, L).

