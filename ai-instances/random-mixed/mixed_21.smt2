; mixed_21.smt2
; C in (0|1)* — any binary string with str.to_int C >= 1000.
; D in 0*10 (encodes t). No int.v.
; Five variables total (C, D, A, B, E). Dense linear system.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.* (re.union (str.to_re "0") (str.to_re "1")))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (<= 1000 (str.to_int C)))
(assert (<= 2 (str.to_int D)))
(assert (>= 0 (+ (* 9 (str.to_int C)) (* (- 7) (str.to_int D)) (* 4 A) (* (- 3) B))))
(assert (<= 0 (+ (* (- 5) (str.to_int C)) (* 3 (str.to_int D)) (* (- 6) A) (* 2 E))))
(assert (>= 100 (+ (* 4 A) (* (- 5) B) (* 3 E))))
(assert (<= (- 200) (+ (* (- 3) B) (* 7 E))))
(check-sat)
