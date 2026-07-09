
(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun e () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ (* 8 a) (+ (* 8 b) (+ (- (* 8 c)) 1000))) x)
    (int.v (+ (* 27 d) (+ (* 27 e) (- 200))) y)
    (<= x y)
  )
)
(check-sat)
