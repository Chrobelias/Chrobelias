; mixed_16.smt2
; C in 0*10 (encodes t). No second String.
; int.v A A: A is a power of the base (discrete log).
; Modular constraint: 15*B = A - E, 0 <= E <= 10.
; Plus extra constraint relating t and A.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v (+ (* (- 2) (str.to_int C)) E) A))
(assert (= (* 15 B) (- A E)))
(assert (<= 0 E))
(assert (<= E 10))
(check-sat)
