; mixed_15.smt2
; C in 1 (0|1)* 0 — binary strings starting with 1 and ending with 0 (even numbers in base t).
; D encodes t via 0*10.
; int.v B E: E = v_t(B). B is even (ends in 0 in base t representation).

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun D () String)
(declare-fun E () Int)
(assert (str.in_re C (re.++ (str.to_re "1") (re.++ (re.* (re.union (str.to_re "0") (str.to_re "1"))) (str.to_re "0")))))
(assert (str.in_re D (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v B E))
(assert (<= 100 (str.to_int C)))
(assert (<= (str.to_int D) B))
(assert (<= 0 (+ (* (- 5) (str.to_int D)) (* 3 B) (* (- 6) E) (* 4 A))))
(check-sat)
