; Instance 08
; Meaning: Is there x > 0 with v(x, y) and v(x+y, y)?
; i.e. adding the valuation to x does not change the valuation.
; Interesting interaction between x and its valuation.
; In base 2: x=3, v_2(3)=1, x+y=4, v_2(4)=4 ≠ 1. 
;            x=2, v_2(2)=2, x+y=4, v_2(4)=4 ≠ 2.
;            x=6, v_2(6)=2, x+y=8, v_2(8)=8 ≠ 2. Looks UNSAT in base 2.
; In base 3: x=2, v_3(2)=1, x+y=3, v_3(3)=3 ≠ 1. 
;            x=4, v_3(4)=1, x+y=5, v_3(5)=1 = 1. SAT! (v_3(5)=1 since 3 does not divide 5)

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v (+ x y) y)
  )
)
(check-sat)
