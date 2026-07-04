; mixed_11.smt2
; C in (0|1)* 1 0 1 (0|1)* — binary strings containing "101" as substring.
; No int.v. Four integer variables with dense constraints.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (re.union (str.to_re "0") (str.to_re "1"))) (re.++ (str.to_re "101") (re.* (re.union (str.to_re "0") (str.to_re "1")))))))
(assert (<= 200 (str.to_int C)))
(assert (int.v (+ (* 7 (str.to_int C)) (* (- 5) A) (* 3 B) (* (- 2) E)) A))
(assert (>= 300 (+ (* 2 A) (* (- 5) E))))
(check-sat)
