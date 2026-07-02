; discrete_log_7.smt2
; a = 200, c = 5 (ceil(2*200/3) = 134, c in [2,134], chosen c=5)
; int.v(x,x): x is a power of the base.
; 200*y = x - z, 0 <= z <= 5.
; x mod 200 in [0, 5]. Extremely tight — only residues 0..5.
; In base 2: 2^0=1✓, 2^1=2✓, 2^2=4✓. SAT.
; In base 199: 199 mod 200 = 199 > 5. 199^0=1✓. SAT.
; In base 3: 3^1=3✓, 3^2=9>5, 3^3=27>5,... but 3^0=1✓. SAT.
; Tests whether powers of the base can reach very small residues mod 200.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 200 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 5))
(check-sat)
