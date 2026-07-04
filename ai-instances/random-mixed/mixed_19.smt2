; mixed_19.smt2
; C in 1 0+ 1 — a 1, then one or more 0s, then a 1: encodes t^k + 1 for some k >= 1.
; Four integer variables, dense constraints.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (str.to_re "1") (re.++ (re.+ (str.to_re "0")) (str.to_re "1")))))
(assert (<= 100 (str.to_int C)))
(assert (int.v (+ (* 8 (str.to_int C)) (* (- 4) E)) A))
(assert (int.v (+ (* 5 E) (- 75)) B))
(assert (<= A B))
(check-sat)
