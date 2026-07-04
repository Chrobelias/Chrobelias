; mixed_3.smt2
; C in (0|1)* 1 (0|1)* — binary strings with at least one 1 (positive integers in base t).
; int.v B A: A = v_t(B).
; Two string-free integers and one String variable.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (re.* (re.union (str.to_re "0") (str.to_re "1"))) (re.++ (str.to_re "1") (re.* (re.union (str.to_re "0") (str.to_re "1")))))))
(assert (int.v B A))
(assert (<= 200 (str.to_int C)))
(assert (<= 0 A))
(assert (>= 0 (+ (* (- 5) (str.to_int C)) (* 3 B) (* 7 A) (* (- 2) E))))
(assert (<= 0 (+ (* 4 (str.to_int C)) (* (- 6) A) (* 1 E))))
(check-sat)
(get-model)
