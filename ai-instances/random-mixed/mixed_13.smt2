; mixed_13.smt2
; C in 0* 1 0* 1 0* — exactly two 1s in the binary representation.
; D encodes t via 0*10.
; No int.v. Constraints link C, D, and three integer variables.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (re.++ (str.to_re "1") (re.++ (re.* (str.to_re "0")) (re.++ (str.to_re "1") (re.* (str.to_re "0"))))))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (<= 100 (str.to_int C)))
(assert (<= (str.to_int D) (str.to_int C)))
(assert (>= 0 (+ (* 4 (str.to_int C)) (* (- 3) (str.to_int D)) (* 2 A) (* (- 1) B))))
(assert (<= 0 (+ (* (- 5) (str.to_int D)) (* 3 A) (* (- 4) B) (* 6 E))))
(assert (>= 50 (+ (* 2 B) (* (- 3) E))))
(check-sat)
