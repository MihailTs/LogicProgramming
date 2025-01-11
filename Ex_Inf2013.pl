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

nat_pair(A, B) :- nat(K), between(0, K, A), B is K - A, B > 0.

gcd(A, 0, A) :- A > 0.
gcd(A, B, G) :- B > 0, R is A mod B, gcd(B, R, G).

coprime(A, B) :- gcd(A, B, 1).

% биекция N -> Q
nat_to_rat(N, [A, B]) :-    
