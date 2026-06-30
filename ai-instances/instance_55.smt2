; Instance 55
; Meaning: x and z have valuations that are far apart multiplicatively,
; but their sum is tightly constrained relative to the larger valuation.
; 1024 = 2^10, 2187 = 3^7. The constraint forces either x or z to be
; enormous relative to their valuation.
; Or-branch: either vx dominates vz by a factor of 32, or vice versa.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun z () Int)
(declare-fun vx () Int)
(declare-fun vz () Int)
(assert
  (and
    (> x 0) (> z 0)
    (int.v x vx)
    (int.v z vz)
    (<= (* 1024 vx) x)
    (<= (* 2187 vz) z)
    (<= (+ x z) (* 4000 (+ vx vz)))
    (or
      (<= (* 32 vz) vx)
      (<= (* 32 vx) vz)
    )
  )
)
(check-sat)
