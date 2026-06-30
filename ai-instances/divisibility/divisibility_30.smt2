; divisibility_30
; Two patterns plus a connective linking x1,y2 with an "or" and a global bound.
; Shared variables a, b, c (3) + x1,y1,x2,y2 (4) = 7.
; F1 = 4*a - b,           G1 = 5*c + 2
; F2 = a + c,             G2 = 3*b - 3*c + 1

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
    (int.v (- (* 4 a) b) x1)
    (int.v (+ (* 5 c) 2) y1)
    (<= x1 y1)
    (int.v (+ a c) x2)
    (int.v (+ (- (* 3 b) (* 3 c)) 1) y2)
    (<= x2 y2)
    (or
      (<= 100 (+ x1 y2))
      (= x1 x2)
    )
  )
)
(check-sat)
