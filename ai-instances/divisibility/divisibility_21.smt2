; divisibility_21
; Two patterns, 4 shared vars a,b,c,d + x1,y1,x2,y2 = 8.
; F1 = 8*a + 4*b - 4*c,   G1 = d + 7
; F2 = a - d,             G2 = 6*b + 6*c

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
    (int.v (+ (* 8 a) (+ (* 4 b) (- (* 4 c)))) x1)
    (int.v (+ d 7) y1)
    (<= x1 y1)
    (int.v (- a d) x2)
    (int.v (+ (* 6 b) (* 6 c)) y2)
    (<= x2 y2)
  )
)
(check-sat)
