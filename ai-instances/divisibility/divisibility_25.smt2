; divisibility_25
; Two patterns with an "or" connecting the two valuation orderings
; (either the first pair is ordered the normal way, or strictly the other way).
; Shared variables a, b, c (3) + x1,y1,x2,y2 (4) = 7.
; F1 = 2*a + 6*b,         G1 = 3*c - 4
; F2 = a - c,             G2 = 5*b + 5*c

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
    (int.v (+ (* 2 a) (* 6 b)) x1)
    (int.v (- (* 3 c) 4) y1)
    (int.v (- a c) x2)
    (int.v (+ (* 5 b) (* 5 c)) y2)
    (or
      (and (<= x1 y1) (<= x2 y2))
      (and (<= y1 x1) (<= y2 x2))
    )
  )
)
(check-sat)
