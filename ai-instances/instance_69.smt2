; Instance 69
; Meaning: A "pigeonhole" flavored instance.
; Four numbers x1, x2, x3, x4 all lie in the interval [10000, 20000].
; Their valuations v1, v2, v3, v4 must all be in [100, 1000].
; The valuation of the pairwise sum x1+x2 must also lie in [100, 1000].
; 10000, 20000 and 100, 1000 are "round" large constants.
; Or-branch: either v1 = v2, or the valuation of x1+x2 strictly exceeds both v1 and v2
; (cancellation occurs).

(set-logic QF_SLIA)
(declare-fun x1 () Int) (declare-fun x2 () Int)
(declare-fun x3 () Int) (declare-fun x4 () Int)
(declare-fun v1 () Int) (declare-fun v2 () Int)
(declare-fun v3 () Int) (declare-fun v4 () Int)
(declare-fun v12 () Int)
(assert
  (and
    (int.v x1 v1) (int.v x2 v2) (int.v x3 v3) (int.v x4 v4)
    (int.v (+ x1 x2) v12)
    (<= 10000 x1) (<= x1 20000)
    (<= 10000 x2) (<= x2 20000)
    (<= 10000 x3) (<= x3 20000)
    (<= 10000 x4) (<= x4 20000)
    (<= 100 v1) (<= v1 1000)
    (<= 100 v2) (<= v2 1000)
    (<= 100 v3) (<= v3 1000)
    (<= 100 v4) (<= v4 1000)
    (<= 100 v12) (<= v12 1000)
    (or
      (= v1 v2)
      (and (< v1 v12) (< v2 v12))
    )
  )
)
(check-sat)
