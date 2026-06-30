; Instance 23
; Meaning: Is there x, y, z with v(x, y), v(y, z), and 4*z = x?
; A valuation chain: v(x)=y, v(y)=z, and x = 4z.
; In base 2: v_2(x) = y, v_2(y) = z, x = 4z = 2^2 * z.
;   x = 4z. v_2(4z) = 4 * v_2(z) = 4z only if v_2(z)=z, i.e. z is a power of 2.
;   Take z=1: x=4, v_2(4)=4 ≠ y=1. z=4: x=16, v_2(16)=16=y, v_2(16)=16=z? z=4≠16.
;   Likely UNSAT in base 2.
; In base 3: v_3(x)=y, v_3(y)=z, x=4z. gcd(4,3)=1 so v_3(4z)=v_3(z).
;   So y = v_3(z). And z = v_3(y) = v_3(v_3(z)).
;   z=1: y=v_3(1)=1, z=v_3(1)=1. x=4*1=4. v_3(4)=1=y ✓. SAT!

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (> z 0)
    (int.v x y)
    (int.v y z)
    (= x (* 4 z))
  )
)
(check-sat)
