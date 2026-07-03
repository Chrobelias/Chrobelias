; mixed_6.smt2
; C in 0*10* — exactly one 1 followed by zeros: encodes t^k for varying k.
; int.v C_int E where C_int = str.to_int C: the string value is a power of the base, and E is its valuation.
; Note: int.v applied to str.to_int directly by aliasing with integer var A.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (re.++ (str.to_re "1") (re.* (str.to_re "0"))))))
(assert (= A (str.to_int C)))
(assert (int.v A E))
(assert (<= 10 A))
(assert (>= 0 (+ (* 3 A) (* (- 5) E) (* 2 B))))
(assert (<= 0 (+ (* (- 4) A) (* 7 E) (* (- 1) B))))
(assert (<= 50 (+ (* 2 A) (* (- 3) B))))
(check-sat)
