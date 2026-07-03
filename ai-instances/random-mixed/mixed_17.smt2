; mixed_17.smt2
; C in (0|1)* 1 1 (0|1)* — binary strings with two consecutive 1s.
; D encodes t^2 via 0*100.
; No int.v. Three integer variables with many constraints.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (re.union (str.to_re "0") (str.to_re "1"))) (re.++ (str.to_re "11") (re.* (re.union (str.to_re "0") (str.to_re "1")))))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (<= 300 (str.to_int C)))
(assert (<= 4 (str.to_int D)))
(assert (>= 0 (+ (* 5 (str.to_int C)) (* (- 4) (str.to_int D)) (* 3 A))))
(assert (<= 0 (+ (* (- 2) (str.to_int C)) (* 5 A) (* (- 3) B) (* 1 E))))
(assert (>= 400 (+ (* 4 A) (* (- 6) B) (* 2 E))))
(assert (<= (- 30) (+ (* (- 3) B) (* 5 E))))
(check-sat)
