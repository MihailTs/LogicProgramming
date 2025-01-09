% Казваме, че крайна редица от числа [a₁, ..., aₙ] е сегментна, 
% ако съществува такава подредица [aₙ₁, aₙ₂, ..., aₙₖ], 
% където 1 ≤ n₁ < n₂ < ... < nₖ ≤ n, че aₙ₁ < aₙ₂ < ... < aₙₖ и 
% ∃c∀i(a_i > a_i₊₁ ⟹ a_i₊₁ = c & ∃j(i = nⱼ)). 
% Да се дефинира на Пролог предикат p(L), 
% който по даден списък от числа L проверява дали той задава сегментна редица.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

neighbor_pairs([], []).
neighbor_pairs([_], []).
neighbor_pairs([A,B|L], [[A,B]|L1]) :- neighbor_pairs([B|L], L1).

p(L) :- neighbor_pairs(L, L1),
        not((member([A1,B1], L1), member([A2,B2], L1),
             A1 > B1, A2 > B2, B1 \= B2
           )).


% Ако E е списък от списъци с дължина 2, да означим с G(E) ориентирания граф,
% в който няма изолирани върхове и между два върха u и v има ребро точно тогава,
% когато [u,v] е елемент на списъка E. Да се дефинира на пролог предикат 
% p(E, V), който по даден списък от двуелементни списъци E и връх V 
% на графа G(E) проверява дали в G(E) има цикъл, преминаващ през V

subsequence([], []).
subsequence([X|L], [X|R]) :- subsequence(L, R).
subsequence([_|L], R) :- subsequence(L, R).

insert(X, L, [X|L]).
insert(X, [H|L], [H|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

subset([], []).
subset(L, S) :- subsequence(L, S1), permutation(S1, S).

vertices([], []).
vertices([[A,B]|E], [A,B|V]) :- vertices(E, V), not(member(A, V)),
    							not(member(B,V)).
vertices([[A,B]|E], [A|V]) :- vertices(E, V), not(member(A, V)),
    						  member(B,V).
vertices([[A,B]|E], [B|V]) :- vertices(E, V), member(A, V),
    						  not(member(B,V)).
vertices([[A,B]|E], V) :- vertices(E, V), member(A, V),
    					  member(B,V).

last_elem([X], X).
last_elem([_|L], X) :- last_elem(L, X).

is_path(_, []).
is_path(E, [X]) :- vertices(E, V), member(X, V).
is_path(E, [A,B|P]) :- member([A,B], E), is_path(E, [B|P]).

p(E, V) :- vertices(E, Verts), subset(Verts, [V|P]),
    	   is_path(E, [V|P]), last_elem([V|P], Last),
    	   member([Last, V], E).
    	   





