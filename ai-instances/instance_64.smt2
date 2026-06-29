; Instance 64
; Meaning: Five numbers form a "valuation staircase": each is at least 10 times
; the next, and each number is at least 100 times its valuation.
; The staircase is x1 >= 10*x2 >= 100*x3 >= 1000*x4 >= 10000*x5.
; All valuations are at least 1, and the smallest number x5 >= 100.

(set-logic QF_SLIA)
(declare-fun x1 () Int)
(declare-fun x2 () Int)
(declare-fun x3 () Int)
(declare-fun x4 () Int)
(declare-fun x5 () Int)
(declare-fun v1 () Int)
(declare-fun v2 () Int)
(declare-fun v3 () Int)
(declare-fun v4 () Int)
(declare-fun v5 () Int)
(assert
  (and
    (int.v x1 v1) (int.v x2 v2) (int.v x3 v3) (int.v x4 v4) (int.v x5 v5)
    (<= (* 10 x2) x1)
    (<= (* 10 x3) x2)
    (<= (* 10 x4) x3)
    (<= (* 10 x5) x4)
    (<= 100 x5)
    (<= (* 100 v1) x1)
    (<= (* 100 v2) x2)
    (<= (* 100 v3) x3)
    (<= (* 100 v4) x4)
    (<= (* 100 v5) x5)
    (<= 1 v5)
  )
)
(check-sat)
