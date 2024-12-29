% https://github.com/YanaRGeorgieva/Logic-programming/blob/master/%D0%98%D0%B7%D0%BF%D0%B8%D1%82%D0%B8%20%D0%BE%D1%82%20%D0%BC%D0%B8%D0%BD%D0%B0%D0%BB%D0%B8%20%D0%B3%D0%BE%D0%B4%D0%B8%D0%BD%D0%B8/%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D0%BD%D0%B8/%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D0%BD%D0%B8%20%D0%98%D0%9D%D0%A4%202017-2018/IMG_20181003_231041364.jpg

% append(A, B, C)
append([], X, X).
append([H|T], L, [H|R]) :- append(T, L, R).

% member(X, L).
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% my_min(L, M)
my_min([X], X).
my_min([X|L], X) :- my_min(L, M), X < M.
my_min([X|L], M) :- my_min(L, M), X >= M.

%my_max(L, M)
my_max([X], X).
my_max([X|L], X) :- my_max(L, M), X > M.
my_max([X|L], M) :- my_max(L, M), X =< M.

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

maxes([], []).
maxes([[X|L]], [M]) :- my_max([X|L], M).
maxes([X|T], [M|R]) :- my_max(X, M), maxes(T, R).

mins([], []).
mins([[X|L]], [M]) :- my_min([X|L], M).
mins([X|T], [M|R]) :- my_min(X, M), mins(T, R).

min_max(L, M) :- maxes(L, R), my_min(R, M).
max_min(L, M) :- mins(L, R), my_max(R, M).

% all_contain(L, M)
all_contain([], _).
all_contain([X|L], M) :- member(M, X), all_contain(L, M).

p(L) :- min_max(L, M1), max_min(L, M2), Balance is M1 - M2,
    	all_contain(L, Balance).
