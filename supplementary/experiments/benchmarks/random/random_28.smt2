
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x y)
    (int.v (+ y (+ y y)) x)
  )
)
(check-sat)
