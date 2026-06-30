; Instance 24
; Meaning: Is there x, y, z, w, u, v with:
;   v(x, y), v(z, w), v(u, v),
;   x + z + u = 12*y, w <= y, v <= y?
; Three numbers whose valuations are all bounded by y = v(x),
; and they sum to 12 times that valuation.
; 12 = 4 * 3 is interesting: divisible by both 4 (base 2 power) and 3.
; 6 variables, 3 int.v atoms, 4 linear constraints.

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
    (> z 0)
    (> u 0)
    (int.v x y)
    (int.v z w)
    (int.v u vv)
    (= (+ x (+ z u)) (* 12 y))
    (<= w y)
    (<= vv y)
  )
)
(check-sat)
