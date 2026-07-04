; mixed_26.smt2
; C in 0*1 0* 1 0* 1 0* — exactly three 1s in binary.
; D in 0*100 (encodes t^2). int.v A B: B = v_t(A).
; Constraints link the three-ones value C, t^2, A, and its valuation B.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (re.++ (str.to_re "1") (re.++ (re.* (str.to_re "0")) (re.++ (str.to_re "1") (re.++ (re.* (str.to_re "0")) (re.++ (str.to_re "1") (re.* (str.to_re "0"))))))))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (int.v A B))
(assert (<= 100 (str.to_int C)))
(assert (<= (str.to_int D) A))
(assert (= 0 (+ (* 5 (str.to_int C)) (* (- 3) (str.to_int D)) (* 4 A) (* (- 6) B))))
(check-sat)
