; divisibility_20
; Two patterns, single shared variable a + b, plus x1,y1,x2,y2 = 6 total.
; F1 = 3*a,               G1 = 3*b
; F2 = a + 1,             G2 = b - 1

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun x1 () Int)
(declare-fun y1 () Int)
(declare-fun x2 () Int)
(declare-fun y2 () Int)
(assert
  (and
    (int.v (* 3 a) x1)
    (int.v (* 3 b) y1)
    (<= x1 y1)
    (int.v (+ a 1) x2)
    (int.v (- b 1) y2)
    (<= x2 y2)
  )
)
(check-sat)
