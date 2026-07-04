; mixed_4.smt2
; C encodes t (base) via 0*10. D encodes t^3 via 0*1000.
; int.v A B: B = v_t(A).
; Constraints relate t, t^3, A and valuation B.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (int.v A B))
(assert (<= (str.to_int C) A))
(assert (<= A (str.to_int D)))
(assert (>= 0 (+ (* 5 (str.to_int C)) (* (- 2) (str.to_int D)) (* 3 A))))
(check-sat)
