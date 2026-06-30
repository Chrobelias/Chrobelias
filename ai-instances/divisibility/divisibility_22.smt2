; divisibility_22
; Two patterns + an extra disequality between the two valuation pairs,
; plus a sum constraint tying everything together (x1 + x2 <= y1 + y2).
; Shared variables a, b, c (3) + x1,y1,x2,y2 (4) = 7.
; F1 = 5*a - 5*b,         G1 = c + 3
; F2 = a + c,             G2 = 2*b + 1

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
    (int.v (- (* 5 a) (* 5 b)) x1)
    (int.v (+ c 3) y1)
    (<= x1 y1)
    (int.v (+ a c) x2)
    (int.v (+ (* 2 b) 1) y2)
    (<= x2 y2)
    (<= (+ x1 x2) (+ y1 y2))
    (not (= x1 x2))
  )
)
(check-sat)
