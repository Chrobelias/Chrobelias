; Instance 29
; Meaning: RANDOM instance with 6 variables and 5 int.v atoms.
; Is there x, y, z, w, u, vv with:
;   v(x, y), v(y, z), v(z, w), v(w, u), v(u, vv),
;   6*x <= 25*vv + z?
; A full depth-5 iterated valuation chain. The chain x -> y -> z -> w -> u -> vv
; must be consistent. This tests deep nesting and is very hard for any base.
; The constraint 6x <= 25*vv + z links the top and bottom of the chain.

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
    (int.v x y)
    (int.v y z)
    (int.v z w)
    (int.v w u)
    (int.v u vv)
    (<= (* 6 x) (+ (* 25 vv) z))
  )
)
(check-sat)
