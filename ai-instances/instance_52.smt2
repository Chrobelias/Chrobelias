; Instance 52
; Meaning: Two numbers x, z whose valuations y, w satisfy a tight inequality chain,
; and the numbers themselves are far apart but their valuations are close.
; 512 = 2^9, 729 = 3^6. The gap between coefficients is large and base-sensitive.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (int.v x y)
    (int.v z w)
    (<= (* 512 y) x)
    (<= (* 729 w) z)
    (<= y (* 2 w))
    (<= w (* 2 y))
    (<= (+ x z) (* 1500 y))
  )
)
(check-sat)
