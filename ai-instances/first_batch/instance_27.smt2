; Instance 27
; Meaning: Is there x, y, z, w, u, vv with:
;   v(x, y), v(z, w), v(u, vv),
;   v(y, z),  (valuation chain: v(x)=y, v(y)=z)
;   4*x = u + vv,
;   w + vv <= y?
; A deep valuation chain (x -> y -> z) combined with a third independent
; valuation v(u, vv), tied together with coefficient constraints.
; 6 variables, 4 int.v atoms, 3 linear constraints.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(declare-fun u () Int)
(declare-fun vv () Int)
(assert
  (and
    (> x 0)
    (> u 0)
    (int.v x y)
    (int.v y z)
    (int.v z w)
    (int.v u vv)
    (= (* 4 x) (+ u vv))
    (<= (+ w vv) y)
  )
)
(check-sat)
