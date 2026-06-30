; divisibility_14
; Two patterns, 4 shared variables a,b,c,d + x1,y1,x2,y2 = 8 total.
; F1 = a + b + c + d,    G1 = 2*a - 2*d
; F2 = 5*b - c,           G2 = d + 100

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
    (int.v (+ a (+ b (+ c d))) x1)
    (int.v (- (* 2 a) (* 2 d)) y1)
    (<= x1 y1)
    (int.v (- (* 5 b) c) x2)
    (int.v (+ d 100) y2)
    (<= x2 y2)
  )
)
(check-sat)
