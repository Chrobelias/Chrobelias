
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (not (= x z))
    (int.v x y)
    (int.v z w)
    (= (+ x z) (+ y w))
  )
)
(check-sat)
