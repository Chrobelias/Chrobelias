; Instance 31
; Meaning: Either x has the same valuation as z, or doubling x gives the same
; valuation as z. I.e. the valuation of x is "close" to that of z, in one of two ways.
; In base 2: v_2(2x) = 2*v_2(x), so the second disjunct says v_2(x)*2 = v_2(z).
; In base 3: v_3(2x) = v_3(x), so both disjuncts collapse to the same condition. Interesting!

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
    (or
      (= y w)
      (int.v (+ x x) w)
    )
    (not (= x z))
  )
)
(check-sat)
