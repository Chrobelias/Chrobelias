
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (<= x (+ y (+ y y)))
    (not (= x y))
  )
)
(check-sat)
