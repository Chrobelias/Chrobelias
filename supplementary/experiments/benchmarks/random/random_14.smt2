
(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x vx)
    (int.v y vy)
    (int.v (+ x y) vs)
    (not (or
      (=> (<= vx vy) (= vs vx))
      (=> (<= vy vx) (= vs vy))
    ))
  )
)
(check-sat)
