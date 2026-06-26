; Instance 19
; Meaning: Is there x, y, z, w, u with v(x, y), v(z, w), v(u, y),
;   x + z = u, and x <= z?
; i.e. the sum of two numbers sharing the first's valuation also has that valuation.
; 5 variables, 3 int.v atoms, 2 linear constraints.
; RANDOM in structure but has some semantic flavor around valuation preservation under addition.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(declare-fun u () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (int.v x y)
    (int.v z w)
    (int.v u y)
    (= u (+ x z))
    (<= x z)
  )
)
(check-sat)
