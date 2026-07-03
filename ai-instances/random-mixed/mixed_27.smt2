; mixed_27.smt2
; C in 0*10 (encodes t). No int.v.
; Four integer variables A, B, E and one String.
; Large coefficients in constraints to stress the linear arithmetic layer.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (<= 2 (str.to_int C)))
(assert (>= 0 (+ (* 97 (str.to_int C)) (* (- 53) A) (* 41 B) (* (- 29) E))))
(assert (<= 0 (+ (* (- 73) (str.to_int C)) (* 61 A) (* (- 47) B) (* 37 E))))
(assert (>= 500 (+ (* 83 A) (* (- 71) B) (* 59 E))))
(assert (<= (- 300) (+ (* (- 67) A) (* 43 B) (* (- 31) E))))
(check-sat)
