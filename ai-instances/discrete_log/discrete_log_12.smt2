; discrete_log_12.smt2
; a = 300, c = 200 (ceil(2*300/3) = 200, c = 200, maximum allowed)
; int.v(x,x): x is a power of the base.
; 300*y = x - z, 0 <= z <= 200.
; x mod 300 in [0, 200].
; In base 2: 2^7=128✓,2^8=256>200. 2^9=512 mod 300=212>200. 2^10=1024 mod 300=124✓. SAT.
; In base 3: 3^4=81✓,3^5=243✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 300 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 200))
(check-sat)
