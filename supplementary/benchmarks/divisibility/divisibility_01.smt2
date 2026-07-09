
(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ (* 2 a) 3) x)
    (int.v (+ (* 4 b) (* 5 c)) y)
    (<= x y)
  )
)
(check-sat)
