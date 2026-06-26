; Instance 11
; Meaning: Is there x, y, z with v(x, y), v(y, z), and z = y?
; i.e. the valuation of the valuation equals the valuation itself — v(v(x)) = v(x).
; This means v(x) is a fixed point of v.
; In base 2: v_2(v_2(x)) = v_2(x) means v_2(x) is a power of 2 whose own valuation equals itself,
;   i.e. v_2(x) = 1 or v_2(x) = 2 or v_2(x) = 4...
;   x=2: v_2(2)=2, v_2(2)=2. z=y=2. SAT.
; In any base: SAT (base itself is a fixed point of v).

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v y z)
    (= z y)
  )
)
(check-sat)
