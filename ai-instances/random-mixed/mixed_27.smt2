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
(assert (int.v (+ 4 (* 2 A)) B))
(assert (= 1 (+ (* 97 (str.to_int C)) (* (- 53) A) (* 41 B) (* (- 29) E))))
(check-sat)
