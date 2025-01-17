% Ще казваме, че списък от естествени числа е квадратичен, ако както дължината му, 
% така и сумата на елементите му са квадрати на естествени числа.
% Да се дефинира предикат на Пролог squareList(L), който проверява 
% дали списък от естествени числа L е квадратичен.

list_length([], 0).
list_length([_|L], N) :- list_length(L, N1), N is N1 + 1.

sum([], 0).
sum([X|L], S) :- sum(L, S1), S is S1 + X.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

squareList(L) :- list_length(L, N),
    			 sum(M),
    			 between(0, N, N1), N is N1 * N1,
    			 between(0, M, M1), M is M1 * M1.

% Представяне на точка (p, q) ∈ Q × Q с рационални координати в равнината 
% наричаме всяка четворка (ap, bp, aq, bq) ∈ Z⁴, за която ap/bp = p и 
% aq/bq = q (в частност bp ≠ 0 ≠ bq). Да се дефинира на Пролог предикат 
% min_cover(S, M), който по даден краен списък S от представяния на точки 
% с рационални координати в равнината генерира в M минимално по размер 
% подмножество на S, така че всяка точка от S попада в поне един кръг 
% с център в точка, представена от елемент на M, и радиус 1.

member(H, [H|_]).
member(H, [_|T]) :- member(H, T).

subsequence([], []).
subsequence([X|L], [X|R]) :- subsequence(L, R).
subsequence([X|L], R) :- subsequence(L, R).

lies_in([[A1,A2], [B1,B2]], [[X1,X2], [Y1,Y2]]) :- 
    								L11 is (X1 * A2 - A1 * X2),
    								L12 is (A2 * X2),
    								L21 is (Y1 * B2 - B1 * Y2),
    								L22 is (B2 * Y2),
    								L1sq1 is L11 * L11,
    								L1sq2 is L12 * L12,
    								L2sq1 is L21 * L21,
    								L2sq2 is L22 * L22,
    								SumSquaresNom is (L1sq1 * L2sq2) + (L2sq1 * L1sq2),
    								SumSquaresDen is (L1sq2 * L2sq2),
    								SumSquaresNom =< SumSquaresDen.

min_cover(S, M) :- subsequence(S, M),
    			   not((member(A, S), 
                       not((member(B, M), 
                            lies_in(A, B)
                          ))
                      )).