; Instance 37
; Meaning: RANDOM — Boolean combination of valuation atoms across 5 variables.
; Three variables x, y, z with individual valuations vx, vy, vz.
; We assert a complex mix: either x and y conspire (same valuation, sum condition),
; or z dominates both but its valuation is small, or all three valuations are distinct
; and ordered. No single "clean" semantic — stress test for the Boolean layer.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vz () Int)
(assert
  (and
    (> x 0) (> y 0) (> z 0)
    (int.v x vx)
    (int.v y vy)
    (int.v z vz)
    (or
      (and
        (= vx vy)
        (= (+ x y) (* 6 vz))
      )
      (and
        (< (+ vx vy) vz)
        (< z (+ x y))
      )
      (and
        (< vx vy)
        (< vy vz)
        (not (= x y))
        (not (= y z))
      )
    )
  )
)
(check-sat)
