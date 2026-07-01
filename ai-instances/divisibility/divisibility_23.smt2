; divisibility_23
; Three patterns, 2 shared vars a, b + x1,y1,x2,y2,x3,y3 = 8 total.
; F1 = a,                 G1 = b
; F2 = a + b,             G2 = a - b + 1
; F3 = 4*a - 2*b,         G3 = 2*a + 4*b

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
    (int.v a x1)
    (int.v b y1)
    (<= x1 y1)
    (int.v (+ a b) x2)
    (int.v (+ (- a b) 1) y2)
    (<= x2 y2)
    (int.v (- (* 4 a) (* 2 b)) x3)
    (int.v (+ (* 2 a) (* 4 b)) y3)
    (<= x3 y3)
  )
)
(check-sat)
