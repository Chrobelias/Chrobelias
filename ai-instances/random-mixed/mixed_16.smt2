; mixed_16.smt2
; C in 0*10 (encodes t). No second String.
; int.v A A: A is a power of the base (discrete log).
; Modular constraint: 150*B = A - E, 0 <= E <= 100.
; Plus extra constraint relating t and A.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v A A))
(assert (= (* 150 B) (- A E)))
(assert (<= 0 E))
(assert (<= E 100))
(assert (<= (str.to_int C) A))
(assert (<= 0 (+ (* (- 2) (str.to_int C)) (* 1 A) (* (- 3) B))))
(check-sat)
