; mixed_18.smt2
; C in 0*10 (base t). int.v B E: E = v_t(B).
; int.v A A: A is a power of the base.
; Two int.v atoms, one String. Constraints link t, A, B, E.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v A A))
(assert (int.v B E))
(assert (<= (str.to_int C) A))
(assert (<= (str.to_int C) B))
(assert (>= 0 (+ (* 4 A) (* (- 3) B) (* 5 E))))
(assert (<= 0 (+ (* (- 2) A) (* 6 E) (* (- 1) (str.to_int C)))))
(check-sat)
