; mixed_25.smt2
; C in (0*10)+ — one or more copies of 0*10, i.e. strings that are concatenations of "t-blocks".
; No int.v. Four integer variables.
; This is a less standard regex but valid over {0,1}: matches e.g. "10", "010", "1010", "10010", etc.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.+ (re.++ (re.* (str.to_re "0")) (str.to_re "10")))))
(assert (<= 50 (str.to_int C)))
(assert (>= 0 (+ (* 7 (str.to_int C)) (* (- 4) A) (* 3 B) (* (- 5) E))))
(assert (<= 0 (+ (* (- 6) (str.to_int C)) (* 5 A) (* (- 2) B) (* 4 E))))
(assert (>= 200 (+ (* 3 A) (* (- 6) E))))
(assert (<= (- 100) (+ (* (- 4) B) (* 5 E) (* 2 (str.to_int C)))))
(check-sat)
