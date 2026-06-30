; divisibility_15
; Two patterns, ordering chained: x1 <= y1, x2 <= y2, and additionally y1 = x2,
; linking the two valuation pairs into a chain x1 <= y1 = x2 <= y2.
; Shared variables a, b, c (3) + x1,y1,x2,y2 (4) = 7.
; F1 = 3*a + 1,          G1 = 2*b + 2*c
; F2 = b + c,            G2 = a - 3*c + 4

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun x1 () Int)
(declare-fun y1 () Int)
(declare-fun x2 () Int)
(declare-fun y2 () Int)
(assert
  (and
    (int.v (+ (* 3 a) 1) x1)
    (int.v (+ (* 2 b) (* 2 c)) y1)
    (<= x1 y1)
    (int.v (+ b c) x2)
    (int.v (+ a (+ (- (* 3 c)) 4)) y2)
    (<= x2 y2)
    (= y1 x2)
  )
)
(check-sat)
