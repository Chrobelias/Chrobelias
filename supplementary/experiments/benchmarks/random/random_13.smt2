
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v y z)
    (int.v (+ x y) w)
    (or
      (= x y)
      (= x (+ (+ y y) z))
      (< (+ y (+ y y)) x)
    )
    (not (= w y))
  )
)
(check-sat)
