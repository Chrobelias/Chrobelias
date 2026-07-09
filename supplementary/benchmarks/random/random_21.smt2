(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun y () Int)
(declare-fun vy () Int)
(assert
  (and
    (int.v x vx)
    (int.v y vy)
    (<= (* 7 vx) x)
    (<= (* 3 vy) y)
    (<= (+ x y) (* 10 vx)))
)
(check-sat)
