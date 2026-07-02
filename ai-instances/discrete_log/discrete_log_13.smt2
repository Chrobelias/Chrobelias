; discrete_log_13.smt2
; a = 500, c = 7 (ceil(2*500/3) = 334, c in [2,334], chosen c=7)
; int.v(x,x): x is a power of the base.
; 500*y = x - z, 0 <= z <= 7.
; x mod 500 in [0, 7]. Very tight for large a.
; In base 2: 2^0=1✓,2^1=2✓,2^2=4✓. SAT.
; In base 3: 3^1=3✓. SAT.
; In base 499: 499 mod 500=499>7. 499^0=1✓. SAT.
; In base 7: 7^1=7✓. SAT.
; In base 8: 8>7. 8^0=1✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 500 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 7))
(check-sat)
