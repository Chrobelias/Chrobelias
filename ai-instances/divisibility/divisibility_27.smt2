; divisibility_27
; Three patterns, 2 shared vars a, b + x1,y1,x2,y2,x3,y3 = 8.
; All three F_i/G_i are scaled versions of a, b to test base-sensitivity.
; F1 = 2*a,               G1 = 2*b
; F2 = 3*a,               G2 = 3*b
; F3 = a + b,             G3 = a - b + 1

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
    (int.v (* 2 a) x1)
    (int.v (* 2 b) y1)
    (<= x1 y1)
    (int.v (* 3 a) x2)
    (int.v (* 3 b) y2)
    (<= x2 y2)
    (int.v (+ a b) x3)
    (int.v (+ (- a b) 1) y3)
    (<= x3 y3)
  )
)
(check-sat)
