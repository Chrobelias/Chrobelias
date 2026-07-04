; mixed_10.smt2
; C encodes t via 0*10. int.v A A: A is a power of the base (discrete log flavor).
; B is the quotient in a modular constraint: 7*B = A - E, 0 <= E <= 64.
; Combines discrete-log pattern with regular base encoding.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v A A))
(assert (= (* 7 B) (- A E)))
(assert (<= 0 E))
(assert (<= E 64))
(assert (<= (str.to_int C) A))
(assert (>= 0 (+ (* 3 (str.to_int C)) (* (- 1) A))))
(check-sat)
