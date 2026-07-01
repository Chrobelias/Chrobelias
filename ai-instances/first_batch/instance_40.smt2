; Instance 40
; Meaning: A conditional valuation shift.
; If v(x) < v(y) then v(x + y) = v(x), which is the p-adic ultrametric equality.
; We test whether this can FAIL: i.e. v(x) < v(y) but v(x+y) ≠ v(x).
; Additionally we require that v(x+y) is also not equal to v(y).
; In classical p-adic arithmetic this always holds (ultrametric), so this should be UNSAT
; in every base — a good correctness test for the solver.

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
    (< vx vy)
    (not (= vs vx))
    (not (= vs vy))
  )
)
(check-sat)
