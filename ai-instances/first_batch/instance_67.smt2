; Instance 67
; Meaning: A "density" instance. x is large but its valuation tower collapses
; fast: v(x) is small relative to x, and v(v(x)) is tiny relative to v(x).
; Absolute lower bounds force x to be in the millions.
; 1048576 = 2^20, 32768 = 2^15, 1024 = 2^10.
; The or-branch handles the case where the tower collapses in one step vs two.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun vvx () Int)
(assert
  (and
    (> x 0)
    (int.v x vx)
    (int.v vx vvx)
    (<= 1048576 x)
    (<= (* 1024 vx) x)
    (or
      (and (<= 32768 vx) (<= (* 1024 vvx) vx) (<= vvx 32))
      (and (<= vx 32768)  (<= 1 vvx) (<= vvx 64))
    )
  )
)
(check-sat)
