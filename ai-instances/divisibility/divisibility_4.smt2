; divisibility_4
; Pattern: int.v(F,x) and int.v(G,y) and x <= y
; F = 12*a
; G = 9*b + 4*c + 5*d

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (* 12 a) x)
    (int.v (+ (* 9 b) (+ (* 4 c) (* 5 d))) y)
    (<= x y)
  )
)
(check-sat)
