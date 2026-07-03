; mixed_5.smt2
; C in 1(0|1)* — binary strings starting with 1 (i.e. the integer is >= t^(len-1)).
; No int.v. Four integer variables A, B, E and one String.
; Dense set of linear constraints.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (str.to_re "1") (re.* (re.union (str.to_re "0") (str.to_re "1"))))))
(assert (<= 300 (str.to_int C)))
(assert (>= 0 (+ (* 7 (str.to_int C)) (* (- 4) A) (* 3 B))))
(assert (<= 0 (+ (* (- 3) (str.to_int C)) (* 5 A) (* (- 2) E))))
(assert (>= 100 (+ (* 2 A) (* (- 5) B) (* 4 E))))
(assert (<= (- 50) (+ (* (- 1) A) (* 6 B) (* (- 3) E))))
(check-sat)
