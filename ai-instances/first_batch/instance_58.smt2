; Instance 58
; Meaning: Four variables x, y, z, w with valuations vx, vy, vz, vw.
; We enforce that all four numbers are in a "large band" around their valuations,
; and the valuations form a non-decreasing sequence.
; The bands use powers of 2 and 3 as multipliers.
; Additionally: the sum of all four numbers is bounded between two large multiples
; of the largest valuation vw.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vz () Int)
(declare-fun vw () Int)
(assert
  (and
    (> x 0) (> y 0) (> z 0) (> w 0)
    (int.v x vx) (int.v y vy) (int.v z vz) (int.v w vw)
    (<= (* 16 vx) x)   (<= x (* 32 vx))
    (<= (* 27 vy) y)   (<= y (* 81 vy))
    (<= (* 128 vz) z)  (<= z (* 256 vz))
    (<= (* 243 vw) w)  (<= w (* 729 vw))
    (<= vx vy) (<= vy vz) (<= vz vw)
    (<= (* 500 vw) (+ x (+ y (+ z w))))
    (<= (+ x (+ y (+ z w))) (* 2000 vw))
  )
)
(check-sat)
