; Instance 60
; Meaning: A "squeeze" on the valuation of a sum.
; x and y individually have large valuations, but their sum's valuation
; is squeezed into a narrow range between two large constants.
; 65536 = 2^16, 59049 = 3^10. Cross-base squeeze.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0) (> y 0)
    (int.v x vx)
    (int.v y vy)
    (int.v (+ x y) vs)
    (<= 65536 vx)
    (<= 59049 vy)
    (<= 65536 vs)
    (<= vs 131072)
    (<= (* 65536 vs) (+ x y))
    (<= vx (* 2 vs))
    (<= vy (* 2 vs))
  )
)
(check-sat)
