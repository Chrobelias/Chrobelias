; Instance 12
; Meaning: Is there x, y, z with v(x, y), v(x, z) (same x), y + z = x?
; Since valuation is unique, y = z, so this becomes y + y = x, i.e. x = 2*v(x).
; In base 2: UNSAT? x=2: v_2(2)=2, 2+2=4 ≠ 2. x=4: v_2(4)=4, 4+4=8 ≠ 4. UNSAT.
; In base 3: x=2: v_3(2)=1, 1+1=2=x. SAT!
; Base-dependent.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v x z)
    (= (+ y z) x)
  )
)
(check-sat)
