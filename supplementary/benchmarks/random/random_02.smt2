
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (> z 0)
    (int.v x y)
    (int.v y z)
    (= x (* 4 z))
  )
)
(check-sat)
