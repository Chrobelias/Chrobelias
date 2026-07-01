; divisibility_6
; Pattern: int.v(F,x) and int.v(G,y) and x <= y
; F = 100*a + 17
; G = 50*b - 25*c + 13*d

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (+ (* 100 a) 17) x)
    (int.v (+ (* 50 b) (+ (- (* 25 c)) (* 13 d))) y)
    (<= x y)
  )
)
(check-sat)
