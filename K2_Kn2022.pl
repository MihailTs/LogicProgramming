% Нивка е краен списък L от двуелементни списъци,
%  вторият член на всеки от които е число 
%  и всеки два различни члена на L имат различни първи членове.
%  Парче от една нивка L е множество,
%  чиито елементи са първи членове от елементи на L. 
%  Размер на едно парче A = {a1, a2, ..., an} на нивката L 
%  е числото RL(A) = p1 + p2 + ... + pn, 
%  където [a1, p1], [a2, p2], ..., [an, pn] са членове на L.

% Да се дефинира на пролог предикат indepen(L), който по дадена нивка L
%  разпознава дали има поне две такива различни парчета A и B на L,
%  че A ∩ B ≠ ∅ и RL(A ∩ B) = RL(A)RL(B).

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

% subset(L, T) -> L е подмн. на T (да приемем, че празното не е)
my_subset([X], T) :- member(X, T).
my_subset([X|L], [X|T]) :- my_subset(L, T).
my_subset(L, [_|T]) :- my_subset(L, T).

% indep(X, Y) - X ∩ Y ≠ ∅
indep([], [_|_]).
indep([A|X], Y) :- not(member(A,Y)), indep(X, Y).

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

% size(X, M) - генерира в M размера на X
size([], 0).
size([[_,B]|X], M) :- size(X, M1), M is M1 + B. 

intersection([], _, []).
intersection([X|Xs], Ys, [X|Zs]) :-
    member(X, Ys), 
    intersection(Xs, Ys, Zs).

intersection([X|Xs], Ys, Zs) :-
    \+ member(X, Ys),
    intersection(Xs, Ys, Zs).

indepen(L) :- my_subset(X,L), my_subset(Y,L), indep(X,Y),
	   		  size(X, M1), size(Y, M2), intersection(X, Y, Z),
    		  size(Z, M3), M3 is M1 * M2.
    		  


