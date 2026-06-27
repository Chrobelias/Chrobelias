; Instance 44
; Meaning: Negation of a "valuation subadditivity" property.
; We claim: it is NOT the case that for all x, y, v(x+y) >= min(v(x), v(y)).
; Since we can't quantify universally, we assert the existential witness:
; there exist x, y > 0 with v(x+y) strictly less than both v(x) and v(y).
; This is the negation of the ultrametric inequality — expected UNSAT in every base.
; A good correctness benchmark.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0) (> y 0)
    (int.v x vx)
    (int.v y vy)
    (int.v (+ x y) vs)
    (< vs vx)
    (< vs vy)
  )
)
(check-sat)
