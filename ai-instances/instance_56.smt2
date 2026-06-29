; Instance 56
; Meaning: A valuation chain x -> vx -> vvx with large separation constraints.
; x is at least 4096 times its valuation vx, and vx is at least 64 times vvx.
; So x >= 4096 * 64 * vvx = 262144 * vvx.
; Additionally the sum x + vx is bounded above by 5000 * vx.
; 4096 = 2^12, 64 = 2^6. Very base-2 flavored.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun vvx () Int)
(assert
  (and
    (> x 0)
    (int.v x vx)
    (int.v vx vvx)
    (<= (* 4096 vx) x)
    (<= (* 64 vvx) vx)
    (<= (+ x vx) (* 5000 vx))
    (<= vvx (* 10 vvx))
    (< vvx vx)
    (< vx x)
  )
)
(check-sat)
