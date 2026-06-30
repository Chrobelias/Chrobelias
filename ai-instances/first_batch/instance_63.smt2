; Instance 63
; Meaning: x and y are both large, their valuations are small relative to them,
; but the valuation of their sum is large relative to the sum.
; This tests "cancellation": when x + y has unexpectedly high valuation.
; 100000 is a round large number; 16384 = 2^14.
; Or-branch: the cancellation happens because either vx = vy (equal valuations cancel),
; or the sum itself is a near-power of the base.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0) (> y 0)
    (int.v x vx) (int.v y vy) (int.v (+ x y) vs)
    (<= 100000 x) (<= 100000 y)
    (<= (* 100 vx) x)
    (<= (* 100 vy) y)
    (<= (* 16384 vs) (+ x y))
    (or (= vx vy) (<= (* 16384 vs) (+ x y)))
  )
)
(check-sat)
