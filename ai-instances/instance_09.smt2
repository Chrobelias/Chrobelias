; Instance 09
; Meaning: Is there x, y, z, w with v(x, y), v(z, w), x = z + z, and y = w + w?
; i.e. doubling x doubles its valuation.
; In base 2: SAT — this is exactly the defining property of 2-adic valuation.
;   E.g. x=4, y=4, z=2, w=2: v_2(2)=2, v_2(4)=4, 4=2+2, 4=2+2. SAT.
; In base 3: SAT or UNSAT? Doubling has no effect on 3-adic valuation, 
;   so y=w, not y=w+w. Likely UNSAT unless y=w=0, but valuation is positive.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> z 0)
    (> w 0)
    (int.v x y)
    (int.v z w)
    (= x (+ z z))
    (= y (+ w w))
  )
)
(check-sat)
