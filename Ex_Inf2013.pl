% Да се дефинира на пролог предикат p(N, M), 
% който по дадено естествено число N генерира в M 
% при преудовлетворяване всички точни делители на N, 
% които са числа от вида 2^n + m^3 за някои естествени n и m.

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

between(A, B, A) :- B >= A.
between(A, B, X) :- B > A, A1 is A + 1, between(A1, B, X).

nat_tri(X, Y, Z) :- nat(K), between(0, K, X), K1 is K - X,
    			 between(0, K1, Y), Z is K1 - Y.

pow(_, 0, 1).
pow(X, Y, R) :- Y > 0, Y1 is Y - 1, pow(X, Y1, R1), R is R1 * X.

p(N, M) :- nat_tri(M, A, B), M \= 0, 0 is (N mod M), 
    	   pow(2, A, P1), pow(B, 3, P2),
     	   M is P1 + P2.
    		

 % Да се дефинира на пролог предикат p(A), който при преудовлетворяване 
% генерира в A всички рационални числа, които са сума 
% от квадратите на три рационални числа.

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

nat_four(A, B, C, D) :- nat(K), between(0, K, A), 
    			  K1 is K - A, between(0, K1, B),
				  K2 is K1 - B, between(0, K2, C),    			
				  D is K2 - C.
    
gcd(A, 0, A) :- A > 0.
gcd(A, B, G) :- B > 0, R is A mod B, gcd(B, R, G).

% функция на Кантор N -> N^2
nat_to_pair(N, [A, B]) :- W is floor((-1 + sqrt(1 + 8 * N)) / 2),
    					  T is W * (W + 1) div 2,
    					  A is W - (N - T),
    					  B is N - T.

square([A,B],[A1,B1]) :- A1 is A^2, B1 is B^2.

normalize([A,B],[A1,B1]) :- gcd(A,B,D), A1 is A div D, B1 is B div D.

sum([A1, B1], [A2, B2], [A3, B3], [A, B]) :- 
    		A is (A1*B2*B3) + (A2*B1*B3) + (A3*B1*B2),
    		B is B1*B2*B3.


% работи, но генерира и много повтарящи се случаи :`)
p([A,B]) :- nat_four(X,Y,Z,U), nat_to_pair(X, [A,B]),
			nat_to_pair(Y, [A1,B1]), nat_to_pair(Z, [A2,B2]),
    		nat_to_pair(U, [A3,B3]),
         	B \= 0, B1 \= 0, B2 \= 0, B3 \= 0,
    		square([A1,B1], [A1sq, B1sq]),
    		square([A2,B2], [A2sq, B2sq]),
    		square([A3,B3], [A3sq, B3sq]),
    		sum([A1sq, B1sq], [A2sq, B2sq], [A3sq, B3sq], [A4, B4]),
			normalize([A4, B4], [A, B]).
