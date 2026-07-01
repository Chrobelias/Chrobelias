; Instance 36
; Meaning: An implication chain between valuation comparisons.
; If v(x) <= v(y) then v(x+y) = v(x), OR
; if v(y) <= v(x) then v(x+y) = v(y).
; We assert the negation: both implications fail simultaneously.
; I.e.: v(x) <= v(y) but v(x+y) ≠ v(x), AND v(y) <= v(x) but v(x+y) ≠ v(y).
; This forces v(x) = v(y) (since both <= hold) but v(x+y) differs from both.
; Tests a p-adic ultrametric property: when |x|=|y|, the sum can be anything <= |x|.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x vx)
    (int.v y vy)
    (int.v (+ x y) vs)
    (not (or
      (=> (<= vx vy) (= vs vx))
      (=> (<= vy vx) (= vs vy))
    ))
  )
)
(check-sat)
