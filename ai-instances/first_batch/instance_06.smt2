; Instance 06
; Meaning: Is there x > 0 such that v(x, y) and y + y + y = x?
; i.e. x is exactly three times its valuation.
; In base 3: SAT — e.g. x=3, y=1 (v_3(3)=1, 1+1+1=3). Wait: v_3(3)=3 not 1.
;   Actually x=3, v_3(3)=3, y=3, y+y+y=9 ≠ 3. Hmm.
;   x=9: v_3(9)=9, y=9, 9+9+9=27 ≠ 9.
;   Let's think differently: we just assert the formula and let the solver decide.
; In base 2: x must be 3*y where y=v_2(x). E.g. x=3: v_2(3)=1, 3*1=3. SAT.
; In base 3: x=3*y where y=v_3(x). v_3(3)=3, 3*3=9 ≠ 3. v_3(9)=9, 3*9=27 ≠ 9. Likely UNSAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (= (+ y (+ y y)) x)
  )
)
(check-sat)
