; discrete_log_10.smt2
; a = 256, c = 171 (ceil(2*256/3) = 171, c = 171, maximum allowed)
; int.v(x,x): x is a power of the base.
; 256*y = x - z, 0 <= z <= 171.
; x mod 256 in [0, 171]. More than 2/3 of residues forbidden from above.
; In base 2: 2^7=128✓, 2^8=256≡0✓. SAT easily.
; In base 3: 3^4=81✓. SAT.
; Complement to discrete_log_9: same a, maximum c.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 256 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 171))
(check-sat)
