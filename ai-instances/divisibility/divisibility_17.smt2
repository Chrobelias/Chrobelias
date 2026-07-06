; divisibility_17
; Two patterns with large coefficients, 4 shared vars a,b,c,d + x1,y1,x2,y2 = 8.
; F1 = 10*a - 6*b,     G1 = 5*c + 25*d
; F2 = a + d,            G2 = 9*b - 9*c + 200

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
    (int.v (- (* 10 a) (* 6 b)) x1)
    (int.v (+ (* 5 c) (* 25 d)) y1)
    (<= x1 y1)
    (int.v (+ a d) x2)
    (int.v (+ (- (* 9 b) (* 9 c)) 20) y2)
    (<= x2 y2)
  )
)
(check-sat)
