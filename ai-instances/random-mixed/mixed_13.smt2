; mixed_13.smt2
; C in 0* 1 0* 1 0* — exactly two 1s in the binary representation.
; D encodes t via 0*10.
; No int.v. Constraints link C, D, and three integer variables.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () Int)
(declare-fun D () String)
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (<= 10 C))
(assert (int.v (+ C (* (- 3) (str.to_int D))) A))
(assert (int.v (* 5 (str.to_int D)) B))
(assert (<= A B))
(check-sat)
