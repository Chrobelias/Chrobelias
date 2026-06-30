; divisibility_28
; Two patterns, 3 shared vars a,b,c + x1,y1,x2,y2 = 7.
; Additional constraint forces strict inequality on the second pair.
; F1 = 9*a - 3*b,         G1 = 4*c + 1
; F2 = a + b + c,         G2 = 2*a - 6*c

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
    (int.v (- (* 9 a) (* 3 b)) x1)
    (int.v (+ (* 4 c) 1) y1)
    (<= x1 y1)
    (int.v (+ a (+ b c)) x2)
    (int.v (- (* 2 a) (* 6 c)) y2)
    (< x2 y2)
  )
)
(check-sat)
