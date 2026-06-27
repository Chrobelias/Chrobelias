; Instance 35
; Meaning: A "case split" on the relationship between x and its valuation.
; Either:
;   (a) x = v(x)  — x is a pure power of the base
;   (b) x = 2*v(x) + v(v(x))  — x is determined by first two levels of valuation tower
;   (c) 3*v(x) < x  — x is "much larger" than its valuation
; We assert that none of these three cases hold simultaneously with a fourth
; constraint: v(x + v(x)) = v(x). Makes for a complex Boolean structure.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v y z)
    (int.v (+ x y) w)
    (or
      (= x y)
      (= x (+ (+ y y) z))
      (< (+ y (+ y y)) x)
    )
    (not (= w y))
  )
)
(check-sat)
