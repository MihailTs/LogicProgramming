% Да се дефинира предикат q(X), който по даден списък от списъци 
% от числа проверява дали някой елемент на четна позиция 
% в предпоследния елемент на X е взаимно прост с всички 
% предпоследни елементи на елементите на X.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

coprime(A, B) :- not((between(2, A, D),
                      0 is A mod D,
                      0 is B mod D
                    )).

prelast([A,_], A).
prelast([_,B,C|L], X) :- prelast([B,C|L], X).

index_help([], [], _).
index_help([X|L], [[X,N]|LI], N) :- N1 is N + 1, index_help(L, LI, N1).

index(L, LI) :- index_help(L, LI, 1).

list_prelasts([], []).
list_prelasts([X|L], [Y|P]) :- prelast(X, Y), list_prelasts(L, P).

q(X) :- prelast(X, Xp), 
    	index(Xp, XpI),
    	member([A,N], XpI),
    	0 is N mod 2,
		list_prelasts(X, Prl),
    	not((member(P, Prl),
             not(coprime(P, A))
           )).

% Да се дефинира предикат sq(X, Y), който по даден списък 
% от списъци X генерира при преудовлетворяване в Y всички списъци, 
% за които съществува такъв префикс Z на някой елемент на X, 
% че Y може да се представи като конкатенация на различни суфикси на Z.

append([], L, L).
append([H|L], T, [H|R]) :- append(L, T, R).

prefix(L, P) :- append(P, _, L).

all_suffixes([], [[]]).
all_suffixes([X|L], [[X|L]|R]) :- all_suffixes(L, R).

subsequence([], []).
subsequence([X|L], [X|R]) :- subsequence(L, R).
subsequence([X|L], R) :- subsequence(L, R).

insert(X, L, [X|L]).
insert(X, [H|L], [H|R]) :- insert(X, L, R).

permutation([], []).
permutation([X|L], P) :- permutation(L, P1), insert(X, P1, P).

subset(X, Y) :- subsequence(X, X1), permutation(X1, Y).

concat_all([], []).
concat_all([X|L], C) :- concat_all(L, C1), append(X, C1, C).

is_concat_suff(Y, Z) :- all_suffixes(Z, Zs),
    					subset(Zs, Suffs),
    					concat_all(Suffs, Y).

% very very very slow but works
sq(X, Y) :- member(A, X),
    		prefix(A, Z),
			is_concat_suff(Y, Z).

