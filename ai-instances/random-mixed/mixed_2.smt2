; mixed_2.smt2
; C in 0*1(0*1)* — strings over {0,1} with at least one 1.
; D encodes t^2 via 0*100.
; No int.v in this instance.
; Three integer variables A, B, E with several linear constraints.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (re.++ (str.to_re "1") (re.* (re.++ (str.to_re "0") (str.to_re "1")))))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (<= (str.to_int D) (str.to_int C)))
(assert (<= 0 (+ (* 5 (str.to_int C)) (* (- 3) (str.to_int D)) (* 2 A))))
(assert (>= 50 (+ (* 4 A) (* (- 1) B) (* 3 E))))
(check-sat)
