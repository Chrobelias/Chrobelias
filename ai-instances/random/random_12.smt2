; Instance 13
; Meaning: Is there x, y, z, w with v(x, y), v(z, w), x + z = y + w?
; i.e. the sum of two numbers equals the sum of their valuations.
; Random-ish structural constraint mixing two independent v atoms with addition.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (not (= x z))
    (int.v x y)
    (int.v z w)
    (= (+ x z) (+ y w))
  )
)
(check-sat)
