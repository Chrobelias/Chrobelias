; mixed_8.smt2
; C encodes t^2 via 0*100. int.v A B: B = v_t(A).
; A is constrained to be between t and t^2.
; Constraints link t^2, A, valuation B, and free integer E.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (int.v A B))
(assert (<= 4 (str.to_int C)))
(assert (<= A (str.to_int C)))
(assert (<= 0 B))
(assert (>= 0 (+ (* 4 (str.to_int C)) (* (- 3) A) (* 5 B) (* (- 2) E))))
(assert (<= 0 (+ (* (- 6) B) (* 4 A) (* (- 1) E))))
(assert (<= 10 (+ (* 3 (str.to_int C)) (* (- 4) B))))
(check-sat)
