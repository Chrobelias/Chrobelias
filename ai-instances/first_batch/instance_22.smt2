; Instance 22
; Meaning: Is there x, y, z, w, u with:
;   v(x, y), v(z, w), v(u, y),
;   3*x + 5*z = 8*u, x <= z?
; The equation 3x + 5z = 8u with shared valuation y for x and u.
; 8 = 2^3 makes this particularly interesting in base 2.
; In base 2: if x and u have the same 2-adic valuation y,
;   and 3x + 5z = 8u, the factor 8 injects exactly 3 extra factors of 2 into u.
; In base 3: 3 divides the left side only through x's contribution.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(declare-fun u () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (> u 0)
    (int.v x y)
    (int.v z w)
    (int.v u y)
    (= (+ (* 3 x) (* 5 z)) (* 8 u))
    (<= x z)
  )
)
(check-sat)
