; mixed_12.smt2
; C encodes t via 0*10. D encodes t^2 via 0*100.
; int.v B E: E = v_t(B). Two regular string variables, three integer variables.
; Constraints relate t, t^2, B, valuation E, and A.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (int.v B E))
(assert (<= (str.to_int C) B))
(assert (<= B (str.to_int D)))
(assert (<= 0 (+ (* (- 6) (str.to_int C)) (* 2 B) (* (- 5) E) (* 3 A))))
(check-sat)
