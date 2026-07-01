; Instance 34
; Meaning: The valuation of x+y is either the valuation of x, or the valuation of y,
; but NOT both (i.e. exactly one of the two). This is an XOR condition.
; This captures a "non-degenerate" ultrametric-like property:
; when two valuations differ, the sum takes the smaller one (in p-adic sense).
; Here we phrase it as an exclusive or.

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
    (not (= vx vy))
    (or
      (and (= vs vx) (not (= vs vy)))
      (and (= vs vy) (not (= vs vx)))
    )
  )
)
(check-sat)
