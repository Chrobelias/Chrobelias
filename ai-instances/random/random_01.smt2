; Instance 01
; Meaning: The valuation is unique — no two distinct values can both be
; the largest power of the base dividing x.
; Expected: UNSAT in every base.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v x z)
    (not (= y z))
  )
)
(check-sat)
