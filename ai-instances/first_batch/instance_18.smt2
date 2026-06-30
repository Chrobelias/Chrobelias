; Instance 18
; Meaning: Is there x, y, z with v(x, y), v(x + y, z), and y = z?
; i.e. adding the valuation of x to x preserves the valuation.
; Compare with instance 08 which uses a different structure.
; In base 2: x=3, v_2(3)=1, x+y=4, v_2(4)=4 ≠ 1. UNSAT?
; In base 5: x=4, v_5(4)=1, x+y=5, v_5(5)=5 ≠ 1. 
;            x=3, v_5(3)=1, x+y=4, v_5(4)=1. SAT!

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v (+ x y) z)
    (= y z)
    (not (= x y))
  )
)
(check-sat)
