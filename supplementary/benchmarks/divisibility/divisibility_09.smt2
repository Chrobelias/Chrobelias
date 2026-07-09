
(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun f () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ (* 15 a) (+ (- (* 7 b)) (+ (* 11 c) (+ (- (* 9 d)) 4)))) x)
    (int.v (- f 1) y)
    (<= x y)
  )
)
(check-sat)
