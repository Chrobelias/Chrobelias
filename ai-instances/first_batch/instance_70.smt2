; Instance 70
; Meaning: A "crossing valuation" instance with very large constants.
; x and y are both at least 1000000, but their valuations must satisfy
; a tight crossing condition: vx is close to vy from above (within factor 2),
; yet 12*x + 8*y is bounded both below and above by large multiples of the
; valuation of 12*x + 8*y (vs).
; 1000000, 2000000 force the solver into a large search space.
; 12 = 4*3, 8 = 2^3 keep the cross-base flavor.
; Or-branch: either vs <= vx, or vs <= vy.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0) (> y 0)
    (int.v x vx) (int.v y vy)
    (int.v (+ (* 12 x) (* 8 y)) vs)
    (<= 1000000 x)  (<= x 2000000)
    (<= 1000000 y)  (<= y 2000000)
    (<= vy vx) (<= vx (* 2 vy))
    (<= (* 500000 vs) (+ (* 12 x) (* 8 y)))
    (<= (+ (* 12 x) (* 8 y)) (* 1000000 vs))
    (or (<= vs vx) (<= vs vy))
  )
)
(check-sat)
