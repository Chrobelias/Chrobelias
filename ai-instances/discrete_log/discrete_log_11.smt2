; discrete_log_11.smt2
; a = 300, c = 10 (ceil(2*300/3) = 200, c in [2,200], chosen c=10)
; int.v(x,x): x is a power of the base.
; 300*y = x - z, 0 <= z <= 10.
; x mod 300 in [0, 10].
; In base 2: 2^0=1✓,2^1=2✓,2^2=4✓,2^3=8✓. SAT.
; In base 7: 7^1=7✓,7^2=49>10. SAT via 7^1.
; In base 11: 11>10. 11^0=1✓. SAT.
; In base 293 (prime < 300): 293 mod 300=293>10. 293^0=1✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 300 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 10))
(check-sat)
