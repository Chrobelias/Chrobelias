
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> z 0)
    (> w 0)
    (int.v x y)
    (int.v z w)
    (= x (+ z z))
    (= y (+ w w))
  )
)
(check-sat)
