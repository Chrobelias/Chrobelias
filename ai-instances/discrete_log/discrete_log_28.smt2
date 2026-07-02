; discrete_log_28.smt2
; a = 1000, c = 667 (ceil(2*1000/3) = 667, c = 667, maximum allowed)
; int.v(x,x): x is a power of the base.
; 1000*y = x - z, 0 <= z <= 667.
; x mod 1000 in [0, 667]. 2/3 of all last-3-digit values allowed.
; In base 2: 2^9=512✓,2^10=24✓. SAT.
; In base 3: 3^6=729>667. 3^5=243✓. SAT.
; In base 9: 9^3=729>667. 9^2=81✓. SAT.
; Maximum c for a=1000.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 1000 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 667))
(check-sat)
