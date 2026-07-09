
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x y)
    (<= y x)
    (<= x (+ y y))
  )
)
(check-sat)
