; discrete_log_17.smt2
; a = 600, c = 400 (ceil(2*600/3) = 400, c = 400, maximum allowed)
; int.v(x,x): x is a power of the base.
; 600*y = x - z, 0 <= z <= 400.
; x mod 600 in [0, 400].
; In base 2: 2^8=256✓,2^9=512✓. SAT easily.
; In base 3: 3^5=243✓,3^6=729 mod 600=129✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 600 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 400))
(check-sat)
