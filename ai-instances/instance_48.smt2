; Instance 48
; Meaning: A "median valuation" property.
; Given three numbers x, y, z, their valuations vx, vy, vz satisfy:
; the valuation of x+y+z is equal to the median of {vx, vy, vz}.
; We encode "vs is the median" as: vs is between the min and max,
; i.e. (vs >= min and vs <= max). We use disjunctions to cover all orderings.
; This is a non-trivial claim about how the Büchi valuation interacts with ternary sums.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vz () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0) (> y 0) (> z 0)
    (int.v x vx)
    (int.v y vy)
    (int.v z vz)
    (int.v (+ x (+ y z)) vs)
    ; vs is the median of {vx, vy, vz}
    (or
      (and (<= vx vs) (<= vs vy))
      (and (<= vy vs) (<= vs vx))
      (and (<= vx vs) (<= vs vz))
      (and (<= vz vs) (<= vs vx))
      (and (<= vy vs) (<= vs vz))
      (and (<= vz vs) (<= vs vy))
    )
    ; and the three valuations are pairwise distinct
    (not (= vx vy))
    (not (= vy vz))
    (not (= vx vz))
  )
)
(check-sat)
