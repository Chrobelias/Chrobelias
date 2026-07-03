; mixed_20.smt2
; C in 0*100 (encodes t^2). int.v A B: B = v_t(A).
; Modular-style constraint: 200*E = A - (str.to_int C) + B.
; Mixes t^2, A, its valuation B, and a modular quotient E.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (int.v A B))
(assert (= (* 200 E) (+ A (- (str.to_int C)) B)))
(assert (<= (str.to_int C) A))
(assert (<= 0 B))
(assert (<= 0 (+ (* 3 A) (* (- 5) B) (* (- 2) (str.to_int C)))))
(assert (>= 0 (+ (* (- 4) A) (* 6 B) (* 1 (str.to_int C)))))
(check-sat)
