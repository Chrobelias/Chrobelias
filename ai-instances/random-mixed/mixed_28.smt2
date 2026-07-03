; mixed_28.smt2
; C in 0*10 (encodes t). int.v A A: A is a power of the base.
; int.v B E: E = v_t(B). Two int.v atoms, one String, five variables total.
; Constraints link t, the power A, B and its valuation E.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v A A))
(assert (int.v B E))
(assert (<= (str.to_int C) A))
(assert (<= (str.to_int C) B))
(assert (<= A B))
(assert (>= 0 (+ (* 5 A) (* (- 3) B) (* 4 E) (* (- 2) (str.to_int C)))))
(assert (<= 0 (+ (* (- 4) A) (* 7 E) (* (- 1) (str.to_int C)))))
(check-sat)
