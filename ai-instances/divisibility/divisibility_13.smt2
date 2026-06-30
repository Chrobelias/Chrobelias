; divisibility_13
; Three patterns chained: y1 feeds nothing, but the variable pool a,b,c (3) + x1,y1,x2,y2,x3,y3 (6) = 9... too many.
; Reduce to 2 shared vars a,b,c (3) + x1,y1,x2,y2 (4) = 7, second pattern reuses x1/y1-derived vars instead.
; F1 = 7*a - 2*b,        G1 = c + 10
; F2 = a + c,             G2 = 3*b - c

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
    (int.v (+ (* 7 a) (- (* 2 b))) x1)
    (int.v (+ c 10) y1)
    (<= x1 y1)
    (int.v (+ a c) x2)
    (int.v (- (* 3 b) c) y2)
    (<= x2 y2)
  )
)
(check-sat)
