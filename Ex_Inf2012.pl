% Нека L е списък, който има следния вид:
% [ [x1, y1], [x2, y2], …, [xn, yn] ].
% Ще казваме, че L представлява бинарната релация R, ако:
% R = {(x1, y1), (x2, y2), …, (xn, yn)}.
% Да се дефинира на Пролог:
% a) едноместен предикат s, който по даден списък L, представляващ бинарната релация R, 
%    разпознава дали R е симетрична релация.
% b) едноместен предикат t, който по даден списък L, представляващ бинарната релация R, \
%    разпознава дали R е транзитивна релация.
% c) триместен предикат c, който по дадени два списъка L1 и L2, 
%    представляващи съответно бинарните релации R1 и R2, генерира в L3 списък, 
%    представляващ композицията R3 на R1 и R2.
% Напомняне: (x, z) ∈ R3 тогава и само тогава, 
% когато има двойки (x, y) ∈ R1 и (y, z) ∈ R2, такива че (x, y) ∈ R1 и (y, z) ∈ R2.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

append([], X, X).
append([H|T], X, [H|Y]) :- append(T, X, Y).

remove(_, [], []).
remove(A, [A|L], L).
remove(A, [B|L], [B|L1]) :- A \= B, remove(A, L, L1).

symmetric([]).
symmetric([[X, X]|R]) :- symmetric(R).
symmetric([[X, Y]|R]) :- member([Y, X], R), remove([Y, X], R, R1), symmetric(R1).

transitive([]).
transitive(R) :- not((member([X,Y], R), member([Y,Z], R), not(member([Z,X], R)))).
    
compose_pair(_, [], []).
compose_pair([X,Y], [[Z,_]|L], C) :- Y \= Z, compose_pair([X,Y], L, C).
compose_pair([X,Y], [[Y,Z]|L], [[X,Z]|C]) :- compose_pair([X,Y], L, C).

compose([], _, []).
compose([[X,Y]|R1], R2, R3) :- compose_pair([X,Y], R2, T), compose(R1, R2, Rt),
    						   append(T, Rt, R3).
    
    
