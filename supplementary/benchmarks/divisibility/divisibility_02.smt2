
(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ (* 6 a) (+ (- (* 4 b)) 9)) x)
    (int.v (+ (* 7 c) 2) y)
    (<= x y)
  )
)
(check-sat)
