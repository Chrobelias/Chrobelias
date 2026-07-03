; mixed_24.smt2
; C in 0*10 (encodes t). int.v A E: E = v_t(A).
; int.v A A would mean A is a power; here just valuation.
; Discrete-log flavor: 500*B = A - E, 0 <= E <= 333.
; Plus a constraint involving t and A.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v A E))
(assert (= (* 500 B) (- A E)))
(assert (<= 0 E))
(assert (<= E 333))
(assert (<= (str.to_int C) A))
(assert (>= 0 (+ (* 4 (str.to_int C)) (* (- 3) A) (* 5 B) (* (- 2) E))))
(check-sat)
