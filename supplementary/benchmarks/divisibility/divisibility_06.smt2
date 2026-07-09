
(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ (* 20 a) 17) x)
    (int.v (+ (* 5 b) (+ (- (* 2 c)) (* 13 d))) y)
    (<= x y)
  )
)
(check-sat)
