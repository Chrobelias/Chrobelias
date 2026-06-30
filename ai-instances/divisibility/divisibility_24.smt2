; divisibility_24
; Two patterns, large constants, 4 shared vars a,b,c,d + x1,y1,x2,y2 = 8.
; F1 = 1000*a - 999*b,    G1 = 500*c + 500*d
; F2 = a + b + c + d,     G2 = 17*a - 17*d + 3

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
    (int.v (- (* 1000 a) (* 999 b)) x1)
    (int.v (+ (* 500 c) (* 500 d)) y1)
    (<= x1 y1)
    (int.v (+ a (+ b (+ c d))) x2)
    (int.v (+ (- (* 17 a) (* 17 d)) 3) y2)
    (<= x2 y2)
  )
)
(check-sat)
