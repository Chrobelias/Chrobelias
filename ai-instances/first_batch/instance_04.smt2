; Instance 04
; Meaning: Is there x, y, z with v(x, y), v(y, z), and x = y + y + y?
; i.e. x is three times its own valuation, and we also track the valuation of the valuation.
; Purely additive chain of valuations.
; Base-dependent: in base 3, x=3 gives v(3,3), v(3,3) so y=3=z works, x=y+y+y=9 ≠ 3. Needs more thought.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x y)
    (int.v y z)
    (= x (+ y (+ y y)))
  )
)
(check-sat)
