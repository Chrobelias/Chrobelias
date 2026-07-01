; Instance 26
; Meaning: RANDOM instance with 5 variables and heavy coefficient use.
; Is there x, y, z, w, u with:
;   v(x, y), v(z, w), v(w, u),
;   7*x + 3*z = w + u,
;   5*y <= 2*z + w?
; Three int.v atoms forming a chain on z (v(z,w) and v(w,u)).
; Coefficients 7, 3, 10 chosen to be a mix of base-2 and base-3 relevant values.
; Purely random structural intent — let the solver find it.

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
    (> w 0)
    (int.v x y)
    (int.v z w)
    (int.v w u)
    (= (+ (* 7 x) (* 3 z)) (+ w u))
    (<= (* 5 y) (+ (* 2 z) w))
  )
)
(check-sat)
