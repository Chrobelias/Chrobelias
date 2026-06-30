; Instance 49
; Meaning: A "split behaviour" instance.
; Either x is a "smooth" number (its valuation is at least half of x),
; or x is "rough" (its valuation is much smaller than x),
; but in both cases the valuation of 6x must equal the valuation of x or
; be a specific multiple of it — creating a base-sensitive split.
; 6 = 2 * 3 makes this particularly interesting.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun v6 () Int)
(declare-fun y () Int)
(declare-fun vy () Int)
(assert
  (and
    (> x 0) (> y 0)
    (int.v x vx)
    (int.v (+ x (+ x (+ x (+ x (+ x x))))) v6)
    (int.v y vy)
    (or
      ; smooth case: vx >= x/2, i.e. 2*vx >= x, and v6 = vx
      (and (<= x (+ vx vx)) (= v6 vx))
      ; rough case: vx < x/2 and v6 differs from vx
      (and (< (+ vx vx) x) (not (= v6 vx)) (<= (* 3 vx) v6))
    )
    ; additionally y is related to x through its valuation
    (= (+ vx vy) (* 4 y))
    (<= y x)
  )
)
(check-sat)
