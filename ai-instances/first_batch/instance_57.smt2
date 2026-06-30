; Instance 57
; Meaning: Two numbers x, y whose valuations satisfy a "ratio" constraint
; expressed via inequalities with large coefficients.
; 343 = 7^3, 2048 = 2^11, 6561 = 3^8.
; We want vx and vy to be in ratio roughly 7:3 (within a factor of 2),
; while x and y are in ratio roughly 2^11 : 3^8.
; Highly base-sensitive due to the mix of prime powers.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(assert
  (and
    (> x 0) (> y 0)
    (int.v x vx)
    (int.v y vy)
    (<= (* 2048 vx) x)  (<= x (* 4096 vx))
    (<= (* 6561 vy) y)  (<= y (* 13122 vy))
    (<= (* 3 vx) (* 7 vy))
    (<= (* 3 vy) (* 7 vx))
    (<= 1 vx)
    (<= 1 vy)
  )
)
(check-sat)
