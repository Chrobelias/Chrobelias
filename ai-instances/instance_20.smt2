; Instance 20
; Meaning: Is there x, y with v(x, y) and v(y + y + y, x)?
; i.e. v(x) = y and v(3y) = x — a "cross" condition.
; In base 3: v_3(3y) = 3 * v_3(y). We need v_3(3y) = x and v_3(x) = y.
;   So x = 3*v_3(y) and y = v_3(x) = v_3(3*v_3(y)).
;   If y=3: v_3(3)=3, x=9, v_3(9)=9 ≠ 3. 
;   If y=1: v_3(3*1)=v_3(3)=3=x, v_3(3)=3 ≠ 1. Likely UNSAT in base 3.
; In base 2: v_2(3y) = v_2(y) (since 3 is odd). So x = v_2(y) and y = v_2(x).
;   y=2: x=v_2(2)=2, y=v_2(2)=2. x=y=2. Check: v_2(2)=2=y ✓, v_2(6)=2=x ✓. SAT!

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x y)
    (int.v (+ y (+ y y)) x)
  )
)
(check-sat)
