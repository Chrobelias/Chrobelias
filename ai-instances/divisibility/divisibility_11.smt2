; divisibility_11
; Two patterns sharing variables a, b, c, d (4 vars) + x1,y1,x2,y2 (4 witnesses) = 8 total.
; F1 = 2*a + 3*b,        G1 = c + d
; F2 = a - c,            G2 = 5*b + 2*d

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun x1 () Int)
(declare-fun y1 () Int)
(declare-fun x2 () Int)
(declare-fun y2 () Int)
(assert
  (and
    (int.v (+ (* 2 a) (* 3 b)) x1)
    (int.v (+ c d) y1)
    (<= x1 y1)
    (int.v (- a c) x2)
    (int.v (+ (* 5 b) (* 2 d)) y2)
    (<= x2 y2)
  )
)
(check-sat)
