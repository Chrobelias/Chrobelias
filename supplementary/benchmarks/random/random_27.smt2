
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(declare-fun u () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (int.v x y)
    (int.v z w)
    (int.v u y)
    (= u (+ x z))
    (<= x z)
  )
)
(check-sat)
