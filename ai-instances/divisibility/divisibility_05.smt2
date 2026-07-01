; divisibility_5
; Pattern: int.v(F,x) and int.v(G,y) and x <= y
; F = 3*a - 2*b - c + 8
; G = e + 6

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun e () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ (* 3 a) (+ (- (* 2 b)) (+ (- c) 8))) x)
    (int.v (+ e 6) y)
    (<= x y)
  )
)
(check-sat)
