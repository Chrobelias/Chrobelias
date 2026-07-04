; mixed_24.smt2
; C in (10)*. int.v A E: E = v_t(A).
; int.v A A would mean A is a power; here just valuation.
; Discrete-log flavor: 150*B = A - E, 0 <= E <= 10.
; Plus a constraint involving t and A.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.* (str.to_re "10"))))
(assert (int.v A E))
(assert (= (* 150 B) (- A E)))
(assert (<= 0 E))
(assert (<= E 10))
(assert (= (str.to_int C) A))
(check-sat)
