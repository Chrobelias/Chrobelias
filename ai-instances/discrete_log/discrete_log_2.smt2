; discrete_log_2.smt2
; a = 75, c = 50 (ceil(2*75/3) = 50, c = 50, maximum allowed)
; int.v(x,x): x is a power of the base.
; 75*y = x - z, 0 <= z <= 50.
; x mod 75 must lie in [0, 50]. Wider window than discrete_log_1.
; Complement to discrete_log_1: same a, opposite extreme of c.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 75 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 50))
(check-sat)
