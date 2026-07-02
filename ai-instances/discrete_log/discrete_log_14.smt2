; discrete_log_14.smt2
; a = 500, c = 334 (ceil(2*500/3) = 334, c = 334, maximum allowed)
; int.v(x,x): x is a power of the base.
; 500*y = x - z, 0 <= z <= 334.
; x mod 500 in [0, 334].
; In base 2: 2^8=256✓,2^9=512 mod 500=12✓. SAT.
; In base 3: 3^5=243✓,3^6=729 mod 500=229✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 500 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 334))
(check-sat)
