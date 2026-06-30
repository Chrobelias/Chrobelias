; Instance 02
; Meaning: Doubling x strictly changes its valuation.
; Is there x > 0 such that v(x, y) and v(x+x, y) (same valuation after doubling)?
; In base 2: UNSAT — doubling always increases 2-adic valuation.
; In base 3: SAT — e.g. x=3, y=3, x+x=6, v_3(6)=3.
; Base-dependent instance.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v (+ x x) y)
  )
)
(check-sat)
