; Instance 53
; Meaning: x is large relative to its valuation, but adding 256 times the valuation
; must not exceed x. And a second number y shares the same valuation zone.
; 256 = 2^8, 243 = 3^5. Very base-sensitive coefficients.
; Or-branch: either x is tightly bounded above by 243*v(x), or x exceeds 1024*v(x).

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun y () Int)
(declare-fun vy () Int)
(assert
  (and
    (> x 0) (> y 0)
    (int.v x vx)
    (int.v y vy)
    (<= (* 256 vx) x)
    (<= x (* 512 vx))
    (<= (* 243 vy) y)
    (<= y (* 486 vy))
    (<= (+ x y) (* 1000 vx))
    (or
      (<= vx vy)
      (<= (* 3 vy) vx)
    )
  )
)
(check-sat)
