; mixed_14.smt2
; C in (0|1)+ with str.to_int C >= 500.
; int.v A B and int.v A E: two valuation atoms on the same A.
; Since valuation is unique, B = E. Tests whether solver detects this.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re C (re.+ (re.union (str.to_re "0") (str.to_re "1")))))
(assert (int.v A B))
(assert (int.v A E))
(assert (<= 500 (str.to_int C)))
(assert (<= A (str.to_int C)))
(assert (>= 0 (+ (* 5 (str.to_int C)) (* (- 4) A) (* 3 B) (* (- 2) E))))
(assert (<= 0 (+ (* (- 3) A) (* 6 B) (* (- 5) E))))
(check-sat)
