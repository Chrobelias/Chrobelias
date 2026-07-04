; mixed_23.smt2
; C in 1(0|1)*1 — binary strings starting and ending with 1 (odd numbers >= 3 in base t).
; D in 0*10 (encodes t). No int.v.
; Five variables, four linear constraints.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (str.to_re "1") (re.* (re.union (str.to_re "01") (str.to_re "10"))))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v (+ (* 6 (str.to_int C)) (* (- 5) (str.to_int D)) B) A))
(assert (<= B 20))
(assert (>= B 1))
(assert (>= A 100))
(check-sat)
