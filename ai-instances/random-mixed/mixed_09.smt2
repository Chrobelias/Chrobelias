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
(assert (int.v (+ (* 3 (str.to_int C)) (* 4 E)) A))
(assert (int.v (+ (* 5 (str.to_int C)) (* (- 3) E)) B))
(assert (<= A B))
(check-sat)
