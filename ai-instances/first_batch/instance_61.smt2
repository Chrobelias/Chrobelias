; Instance 61
; Meaning: Three numbers in arithmetic progression (z = x + d, y = x + 2*d)
; with a large common difference, and their valuations are also constrained.
; The valuation of the middle term y must be at least 1000.
; The common difference d is itself bounded by its valuation vd.
; Or-branch: either vx < vy, or vz < vy (middle valuation dominates at least one end).

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun d () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vz () Int)
(declare-fun vd () Int)
(assert
  (and
    (> x 0) (> d 0)
    (= y (+ x d))
    (= z (+ x (+ d d)))
    (int.v x vx) (int.v y vy) (int.v z vz) (int.v d vd)
    (<= 1000 vy)
    (<= (* 128 vd) d)
    (<= 500 vd)
    (<= vx (* 4 vy))
    (<= vz (* 4 vy))
    (or (< vx vy) (< vz vy))
  )
)
(check-sat)
