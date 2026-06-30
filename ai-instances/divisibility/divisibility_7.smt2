; divisibility_7
; Pattern: int.v(F,x) and int.v(G,y) and x <= y
; F = a - b
; G = c - d + e

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun e () Int)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (int.v (- a b) x)
    (int.v (+ c (+ (- d) e)) y)
    (<= x y)
  )
)
(check-sat)
