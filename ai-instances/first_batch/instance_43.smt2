; Instance 43
; Meaning: A "tournament" on three numbers: for each pair, one dominates the other
; in both value and valuation, OR their valuations cross (bigger number has smaller valuation).
; The crossing condition (larger number, smaller valuation) is base-dependent and unusual.

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
    ; x vs y: either consistent or crossing
    (or (and (<= x y) (<= vx vy))
        (and (<= x y) (< vy vx))
        (and (< y x) (< vx vy)))
    ; y vs z: either consistent or crossing
    (or (and (<= y z) (<= vy vz))
        (and (<= y z) (< vz vy))
        (and (< z y) (< vy vz)))
    ; require at least one crossing pair
    (or
      (and (<= x y) (< vy vx))
      (and (<= y z) (< vz vy))
    )
    ; and a linking arithmetic constraint
    (= (+ vx vz) (* 3 vy))
  )
)
(check-sat)
