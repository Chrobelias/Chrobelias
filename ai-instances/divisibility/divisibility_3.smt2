; divisibility_3
; Pattern: int.v(F,x) and int.v(G,y) and x <= y
; F = a + b + c + 1
; G = 10*d - 3

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ a (+ b (+ c 1))) x)
    (int.v (+ (* 10 d) (- 3)) y)
    (<= x y)
  )
)
(check-sat)
