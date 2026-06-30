; Instance 54
; Meaning: Three numbers with a valuation chain constraint and large coefficients.
; x, y, z have valuations vx, vy, vz. We require:
;   - x is between 128 and 256 times vx
;   - y is between 81 and 243 times vy
;   - z is between 625 and 3125 times vz
;   - and vx + vy + vz <= 100
; 128=2^7, 256=2^8, 81=3^4, 243=3^5, 625=5^4, 3125=5^5.
; The last constraint caps the valuations, forcing the numbers themselves to be large.

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
    (<= (* 128 vx) x)   (<= x (* 256 vx))
    (<= (* 81 vy) y)    (<= y (* 243 vy))
    (<= (* 625 vz) z)   (<= z (* 3125 vz))
    (<= (+ vx (+ vy vz)) 100)
    (<= 10 vx)
  )
)
(check-sat)
