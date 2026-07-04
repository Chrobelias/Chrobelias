; mixed_22.smt2
; C in 0*1000 (encodes t^3). int.v A B: B = v_t(A).
; int.v A A would mean A is a power of t; here B is just the valuation.
; Constraints: A is between t^2 (implicit) and t^3, and 31*E = A - B.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (int.v A B))
(assert (= (* 31 E) (- A (str.to_int C))))
(assert (= B (str.to_int C)))
(assert (<= A (str.to_int C)))
(check-sat)
