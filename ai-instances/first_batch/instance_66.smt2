; Instance 66
; Meaning: x, y, z with valuations vx, vy, vz.
; We enforce a "Farey-like" mediant condition with large coefficients:
; the valuation of 5x + 7y is between 100 times vz and 200 times vz,
; and z itself is between 10000 and 50000.
; 5, 7 are coprime to both 2 and 3, making this interesting across bases.
; Or: vz <= vx or vz <= vy (one of the individual valuations dominates).

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
    (int.v x vx) (int.v y vy) (int.v z vz)
    (int.v (+ (* 5 x) (* 7 y)) vs)
    (<= 10000 z) (<= z 50000)
    (<= (* 100 vz) vs)
    (<= vs (* 200 vz))
    (<= (* 64 vx) x)
    (<= (* 64 vy) y)
    (or (<= vz vx) (<= vz vy))
  )
)
(check-sat)
