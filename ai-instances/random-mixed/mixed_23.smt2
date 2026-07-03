; mixed_23.smt2
; C in 1(0|1)*1 — binary strings starting and ending with 1 (odd numbers >= 3 in base t).
; D in 0*10 (encodes t). No int.v.
; Five variables, four linear constraints.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (str.to_re "1") (re.++ (re.* (re.union (str.to_re "0") (str.to_re "1"))) (str.to_re "1")))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (<= 200 (str.to_int C)))
(assert (<= 2 (str.to_int D)))
(assert (>= 0 (+ (* 6 (str.to_int C)) (* (- 5) (str.to_int D)) (* 4 A) (* (- 3) B))))
(assert (<= 0 (+ (* (- 3) (str.to_int C)) (* 2 (str.to_int D)) (* (- 4) A) (* 5 E))))
(assert (>= 150 (+ (* 3 B) (* (- 4) E))))
(assert (<= (- 60) (+ (* (- 5) A) (* 3 B) (* (- 2) E))))
(check-sat)
