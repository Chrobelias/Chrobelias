; discrete_log_5.smt2
; a = 150, c = 73 (ceil(2*150/3) = 100, c in [2,100], chosen c=73)
; int.v(x,x): x is a power of the base.
; 150*y = x - z, 0 <= z <= 73.
; x mod 150 in [0, 73].
; In base 2: 2^0=1✓, 2^7=128>73 mod 150=128>73, 2^9=512 mod 150=62✓. SAT.
; In base 5: 5^1=5✓, 5^2=25✓, 5^3=125>73 mod 150=125>73. 5^4=625 mod 150=25✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 150 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 73))
(check-sat)
