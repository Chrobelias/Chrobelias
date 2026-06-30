; Instance 62
; Meaning: x has a "deep" valuation tower: v(x) = vx, v(vx) = vvx, v(vvx) = vvvx.
; All three levels are bounded below by large constants, and the ratios
; between consecutive levels are constrained.
; 32768 = 2^15, 1024 = 2^10, 32 = 2^5. Powers of 2 at each level.
; The tower shrinks rapidly: x >> vx >> vvx >> vvvx.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun vvx () Int)
(declare-fun vvvx () Int)
(assert
  (and
    (> x 0)
    (int.v x vx)
    (int.v vx vvx)
    (int.v vvx vvvx)
    (<= (* 32768 vx) x)
    (<= (* 1024 vvx) vx)
    (<= (* 32 vvvx) vvx)
    (<= 1 vvvx)
    (<= x (* 65536 vx))
    (<= vx (* 2048 vvx))
    (<= vvx (* 64 vvvx))
  )
)
(check-sat)
