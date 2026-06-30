; divisibility_10
; Pattern: int.v(F,x) and int.v(G,y) and x <= y
; F = 2*a + 4*b + 6*c + 8*d - 30
; G = 3*e + 9*f + 27

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun e () Int)
(declare-fun f () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ (* 2 a) (+ (* 4 b) (+ (* 6 c) (+ (* 8 d) (- 30))))) x)
    (int.v (+ (* 3 e) (+ (* 9 f) 27)) y)
    (<= x y)
  )
)
(check-sat)
