; Instance 15
; Meaning: Is there x, y, z with v(x, y), v(y, z), v(z, x)?
; i.e. a valuation cycle of length 3: v(x)=y, v(y)=z, v(z)=x.
; In any base: x must equal v(v(v(x))), a third iterate fixed point.
; Likely UNSAT in most bases (valuations are "decreasing" in some sense),
; but interesting to test.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (> z 0)
    (int.v x y)
    (int.v y z)
    (int.v z x)
  )
)
(check-sat)
