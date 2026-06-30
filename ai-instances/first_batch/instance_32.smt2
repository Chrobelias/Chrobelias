; Instance 32
; Meaning: For every "shape" of valuation, either x dominates z or z dominates x
; in terms of both value and valuation — but they are not equal.
; We assert: (x < z and y < w) or (z < x and w < y), i.e. x and z are
; "ordered consistently" with their valuations, and additionally the
; valuation of their sum lands above both individual valuations.
; Tests whether consistent ordering + sum-valuation-dominance is satisfiable.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(declare-fun u () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (int.v x y)
    (int.v z w)
    (int.v (+ x z) u)
    (or
      (and (< x z) (< y w))
      (and (< z x) (< w y))
    )
    (and (<= y u) (<= w u))
  )
)
(check-sat)
