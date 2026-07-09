
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun z () Int)
(declare-fun vz () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (int.v x vx)
    (int.v z vz)
    (<= (* 4 x) z)
    (< vz vx)
  )
)
(check-sat)
