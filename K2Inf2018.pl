% is_rect([Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]) :- Ax = Bx, Dx = Cx,
%                                                    Ay = Dy, By = Cy.

% dalzhinata na kvadrat
length([Ax, Ay], [Bx, By], L) :- M1 is Ax-Bx, M2 is Ay-By, L is M1*M1+M2*M2.

% dve po dve ravni strani i pitagorova teorema za 3 ot tochkite
is_rect([Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]) :-
    length([Ax, Ay], [Bx, By], L1), length([Dx, Dy], [Cx, Cy], L2), L1 = L2,
    length([Ax, Ay], [Dx, Dy], L3), length([Bx, By], [Cx, Cy], L4), L3 = L4,
    length([Ax, Ay], [Cx, Cy], Diagonal), Diagonal is L1+L3.





