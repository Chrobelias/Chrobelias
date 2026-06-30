; divisibility_26
; Two patterns, 4 shared vars a,b,c,d + x1,y1,x2,y2 = 8.
; F1 = a + 2*b - c,       G1 = 3*d + 6
; F2 = 2*a - 2*c,         G2 = b + d - 1

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
    (int.v (+ a (+ (* 2 b) (- c))) x1)
    (int.v (+ (* 3 d) 6) y1)
    (<= x1 y1)
    (int.v (- (* 2 a) (* 2 c)) x2)
    (int.v (- (+ b d) 1) y2)
    (<= x2 y2)
  )
)
(check-sat)
