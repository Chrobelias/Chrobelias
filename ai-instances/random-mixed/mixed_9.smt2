; mixed_9.smt2
; C in 1 0* 1 0* — binary strings of the form 1...0...1...0...: two separated 1-bits.
; No int.v. Four integer variables.
; str.to_int C represents a number whose base-t representation has exactly two 1s.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (str.to_re "1") (re.++ (re.* (str.to_re "0")) (re.++ (str.to_re "1") (re.* (str.to_re "0")))))))
(assert (<= 50 (str.to_int C)))
(assert (>= 0 (+ (* 5 (str.to_int C)) (* (- 3) A) (* 2 B))))
(assert (<= 0 (+ (* (- 4) (str.to_int C)) (* 6 A) (* (- 5) E))))
(assert (>= 500 (+ (* 3 A) (* (- 7) B) (* 4 E))))
(assert (<= (- 100) (+ (* (- 2) A) (* 5 B) (* (- 3) E))))
(check-sat)
