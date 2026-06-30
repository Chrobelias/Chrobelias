; divisibility_2
; Pattern: int.v(F,x) and int.v(G,y) and x <= y
; F = 6*a - 4*b + 9
; G = 7*c + 2

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
