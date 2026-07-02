; discrete_log_21.smt2
; a = 810, c = 540 (ceil(2*810/3) = 540, c = 540, maximum allowed)
; int.v(x,x): x is a power of the base.
; 810*y = x - z, 0 <= z <= 540.
; x mod 810 in [0, 540]. 810 = 2*3^4*5.
; In base 3: 3^5=243✓,3^6=729>540. 3^7=2187 mod 810=567>540. 3^8=6561 mod 810=261✓. SAT.
; In base 2: 2^9=512✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 810 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 540))
(check-sat)
