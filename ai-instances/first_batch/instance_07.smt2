; Instance 07
; Meaning: Is there x, y, z with v(x, y), v(x+x+x, z), and y = z?
; i.e. tripling x preserves its valuation.
; In base 3: SAT — tripling multiplies by 3, increasing 3-adic valuation. Actually UNSAT in base 3.
; In base 2: SAT — tripling doesn't affect 2-adic valuation. E.g. x=2, y=2, x+x+x=6, v_2(6)=2. SAT.
; Base-dependent.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v (+ x (+ x x)) z)
    (= y z)
  )
)
(check-sat)
