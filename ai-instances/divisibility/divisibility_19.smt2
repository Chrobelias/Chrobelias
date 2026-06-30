; divisibility_19
; Two patterns, 5 shared vars a,b,c,d,e + x1,y1,x2,y2 -> would be 9, so we drop one var: reuse e in both.
; Shared variables a, b, c, d (4) + x1,y1,x2,y2 (4) = 8.
; F1 = 11*a - 5*b + 2,    G1 = 13*c + d
; F2 = a + b + c + d,     G2 = 4*a - 4*c

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
    (int.v (+ (- (* 11 a) (* 5 b)) 2) x1)
    (int.v (+ (* 13 c) d) y1)
    (<= x1 y1)
    (int.v (+ a (+ b (+ c d))) x2)
    (int.v (- (* 4 a) (* 4 c)) y2)
    (<= x2 y2)
  )
)
(check-sat)
