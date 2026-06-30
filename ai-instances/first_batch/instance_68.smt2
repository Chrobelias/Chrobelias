; Instance 68
; Meaning: Six variables, six int.v atoms, many inequalities.
; A "valuation budget" instance: the total budget of valuations is at most B=500,
; but each number must be at least 1000 times its valuation, so each number
; is at least 1000. The sum of all six numbers is then at least 6000 and at most
; 500 * 1000 = 500000. We also require the six valuations to be distinct positive integers.
; The or-branch: the largest number exceeds 100000, or the sum exceeds 200000.

(set-logic QF_SLIA)
(declare-fun x1 () Int) (declare-fun x2 () Int) (declare-fun x3 () Int)
(declare-fun x4 () Int) (declare-fun x5 () Int) (declare-fun x6 () Int)
(declare-fun v1 () Int) (declare-fun v2 () Int) (declare-fun v3 () Int)
(declare-fun v4 () Int) (declare-fun v5 () Int) (declare-fun v6 () Int)
(assert
  (and
    (int.v x1 v1) (int.v x2 v2) (int.v x3 v3)
    (int.v x4 v4) (int.v x5 v5) (int.v x6 v6)
    (<= (* 1000 v1) x1) (<= (* 1000 v2) x2) (<= (* 1000 v3) x3)
    (<= (* 1000 v4) x4) (<= (* 1000 v5) x5) (<= (* 1000 v6) x6)
    (<= 1 v1) (<= 1 v2) (<= 1 v3) (<= 1 v4) (<= 1 v5) (<= 1 v6)
    (<= (+ v1 (+ v2 (+ v3 (+ v4 (+ v5 v6))))) 500)
    (< v1 v2) (< v2 v3) (< v3 v4) (< v4 v5) (< v5 v6)
    (or
      (<= 100000 x6)
      (<= 200000 (+ x1 (+ x2 (+ x3 (+ x4 (+ x5 x6))))))
    )
  )
)
(check-sat)
