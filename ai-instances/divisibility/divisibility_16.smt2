; divisibility_16
; Three patterns. Shared variables a, b (2) + x1,y1,x2,y2,x3,y3 (6) = 8 total.
; F1 = 6*a,              G1 = 4*b + 3
; F2 = a + b,            G2 = a - b
; F3 = 2*a + 5*b,        G3 = 7*a - 7*b + 1

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun x1 () Int)
(declare-fun y1 () Int)
(declare-fun x2 () Int)
(declare-fun y2 () Int)
(declare-fun x3 () Int)
(declare-fun y3 () Int)
(assert
  (and
    (int.v (* 6 a) x1)
    (int.v (+ (* 4 b) 3) y1)
    (<= x1 y1)
    (int.v (+ a b) x2)
    (int.v (- a b) y2)
    (<= x2 y2)
    (int.v (+ (* 2 a) (* 5 b)) x3)
    (int.v (+ (- (* 7 a) (* 7 b)) 1) y3)
    (<= x3 y3)
  )
)
(check-sat)
