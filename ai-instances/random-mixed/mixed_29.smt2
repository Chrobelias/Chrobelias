; mixed_29.smt2
; C in (0|1)* 1 0 0 — binary strings ending in "100" (i.e. divisible by 4 but not 8 in base 2,
; or more generally: last two digits are 00 and the one before is 1).
; D in 0*10 (encodes t). No int.v. Three integer variables.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (re.union (str.to_re "0") (str.to_re "1"))) (str.to_re "100"))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (<= 100 (str.to_int C)))
(assert (<= 2 (str.to_int D)))
(assert (>= 0 (+ (* 6 (str.to_int C)) (* (- 5) (str.to_int D)) (* 3 A) (* (- 4) B))))
(assert (<= 0 (+ (* (- 4) (str.to_int C)) (* 3 (str.to_int D)) (* (- 5) A) (* 6 E))))
(assert (>= 300 (+ (* 5 B) (* (- 3) E))))
(check-sat)
