; mixed_7.smt2
; C in (0|1)+ with str.to_int C >= 1000: a large binary-representable number.
; D encodes t via 0*10.
; No int.v. Three integer variables.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.+ (re.union (str.to_re "0") (str.to_re "1")))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (<= 1000 (str.to_int C)))
(assert (<= 2 (str.to_int D)))
(assert (>= 0 (+ (* 6 (str.to_int C)) (* (- 5) (str.to_int D)) (* 4 A))))
(assert (<= 0 (+ (* (- 3) (str.to_int C)) (* 2 (str.to_int D)) (* (- 7) B) (* 1 E))))
(assert (>= 200 (+ (* 5 A) (* (- 2) B) (* 3 E))))
(check-sat)
