; divisibility_24
; Two patterns, large constants, 4 shared vars a,b,c,d + x1,y1,x2,y2 = 8.
; F1 = 100*a - 99*b,    G1 = 50*c + 50*d
; F2 = a + b + c + d,     G2 = a - d + 3

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
    (int.v (- (* 100 a) (* 99 b)) x1)
    (int.v (+ (* 50 c) (* 50 d)) y1)
    (<= x1 y1)
    (int.v (+ a (+ b (+ c d))) x2)
    (int.v (+ (- a d) 3) y2)
    (<= x2 y2)
  )
)
(check-sat)
