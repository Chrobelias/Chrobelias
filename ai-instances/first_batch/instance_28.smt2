; Instance 28
; Meaning: Is there x, y, z, w with:
;   v(x, y), v(z, w),
;   v(x + z, y),    (x+z has the same valuation as x)
;   15*y = 8*w + z?
; The constraint v(x+z, y) = v(x, y) is very restrictive.
; 15 = 3 * 5 and 8 = 2^3.
; In base 2: for v_2(x+z) = v_2(x) = y, we need z to contribute no lower
;   powers of 2 than x. Combined with 15y = 8w + z this is highly constrained.
; In base 3: 15 = 3*5, so 15y injects a factor of 3 relative to y.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (int.v x y)
    (int.v z w)
    (int.v (+ x z) y)
    (= (* 15 y) (+ (* 8 w) z))
  )
)
(check-sat)
