; Instance 21
; Meaning: Is there x, y, z, w with v(x, y), v(z, w), and 6*x = 10*z + y - w?
; Mixes two valuations with non-trivial integer coefficients.
; The coefficients 6 and 10 share factor 2, making this base-2 sensitive.
; In base 2: y = v_2(x), w = v_2(z). 6x - y = 10z - w.
; In base 3: y = v_3(x), w = v_3(z). Different constraints.
; Base-dependent due to asymmetric coefficients.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (int.v x y)
    (int.v z w)
    (= (* 6 x) (+ (* 10 z) (- y w)))
  )
)
(check-sat)
