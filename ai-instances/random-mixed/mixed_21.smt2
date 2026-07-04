; mixed_21.smt2
; C in (0|1)* — any binary string with str.to_int C >= 1000.
; D in 0*10 (encodes t). No int.v.
; Five variables total (C, D, A, B, E). Dense linear system.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(assert (str.in_re C (re.* (re.union (str.to_re "01") (str.to_re "10")))))
(assert (str.in_re D (re.++ (re.* (str.to_re "00")) (str.to_re "11"))))
(assert (int.v (+ (* 9 (str.to_int C)) 7) A))
(assert (int.v (+ (* 4 (str.to_int D)) (- 7)) B))
(assert (<= A B))
(check-sat)
