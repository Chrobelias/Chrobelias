; Instance 50
; Meaning: A "valuation fixed-point vs escape" dichotomy with full Boolean nesting.
; For x and y, either:
;   (A) x is a fixed point of v (v(x)=x) and y escapes upward (v(y) > y is impossible
;       since v(y) always divides y, so we use v(y+y) > v(y) as proxy for "y escapes")
;   (B) y is a fixed point and x escapes: v(x+x) > v(x) and v(y) = y
;   (C) neither is a fixed point but their valuations sum to the valuation of x+y
; And in all cases: 5*v(x) + 3*v(y) <= 8*(x+y).
; The constant 8 = 2^3 again makes base-2 special.
; 5 variables, 5 int.v atoms, rich Boolean structure.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vx2 () Int)
(declare-fun vy2 () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0) (> y 0)
    (int.v x vx)
    (int.v y vy)
    (int.v (+ x x) vx2)
    (int.v (+ y y) vy2)
    (int.v (+ x y) vs)
    (or
      ; (A) x is fixed point, y "escapes" (doubling changes valuation)
      (and (= vx x) (not (= vy2 vy)))
      ; (B) y is fixed point, x escapes
      (and (= vy y) (not (= vx2 vx)))
      ; (C) neither fixed, but valuations sum to joint valuation
      (and (not (= vx x)) (not (= vy y)) (= (+ vx vy) vs))
    )
    (<= (+ (* 5 vx) (* 3 vy)) (* 8 (+ x y)))
  )
)
(check-sat)
