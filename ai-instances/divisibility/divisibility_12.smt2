; divisibility_12
; Two patterns. Shared variables a, b (only 2) + x1,y1,x2,y2 = 6 total.
; F1 = 4*a + 1,         G1 = 6*b - 1
; F2 = a + b,           G2 = 9*a - 3*b + 5

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun x1 () Int)
(declare-fun y1 () Int)
(declare-fun x2 () Int)
(declare-fun y2 () Int)
(assert
  (and
    (int.v (+ (* 4 a) 1) x1)
    (int.v (- (* 6 b) 1) y1)
    (<= x1 y1)
    (int.v (+ a b) x2)
    (int.v (+ (* 9 a) (+ (- (* 3 b)) 5)) y2)
    (<= x2 y2)
  )
)
(check-sat)
