; mixed_1.smt2
; C is a repunit (1,11,111,...), D encodes t (the base) via 0*10.
; int.v A E: E = v_t(A), largest power of t dividing A.
; Linear constraints mix repunit, base, A, B, and valuation E.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.+ (str.to_re "1"))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v A E))
(assert (<= (str.to_int D) A))
(assert (>= 10 (+ (* 3 (str.to_int C)) (* (- 2) A) (* 5 E))))
(assert (<= 1 (+ (* 7 (str.to_int D)) (* (- 1) B) (* 2 E))))
(check-sat)
