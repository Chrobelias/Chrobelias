
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v (+ x y) z)
    (= y z)
    (not (= x y))
  )
)
(check-sat)
