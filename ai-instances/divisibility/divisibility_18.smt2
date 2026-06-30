; divisibility_18
; Two patterns with an extra linking inequality between y1 and x2 (y1 <= x2),
; forming a 3-level chain: x1 <= y1 <= x2 <= y2.
; Shared variables a, b, c (3) + x1,y1,x2,y2 (4) = 7.
; F1 = a - b,            G1 = 2*c + 1
; F2 = b + c,            G2 = 3*a + 3*b

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
    (int.v (- a b) x1)
    (int.v (+ (* 2 c) 1) y1)
    (<= x1 y1)
    (int.v (+ b c) x2)
    (int.v (+ (* 3 a) (* 3 b)) y2)
    (<= x2 y2)
    (<= y1 x2)
  )
)
(check-sat)
