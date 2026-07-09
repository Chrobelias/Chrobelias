
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun v1 () Int)
(declare-fun v2 () Int)
(declare-fun v3 () Int)
(assert
  (and
    (> x 0)
    (int.v x v1)
    (int.v (+ x x) v2)
    (int.v (+ x (+ x x)) v3)
    (or
      (and (= v1 v2) (= v2 v3))
      (and (not (= v1 v2)) (not (= v2 v3)) (not (= v1 v3)))
    )
  )
)
(check-sat)
