; Instance 16
; Meaning: Is there x, y with v(x, y) and x <= y + y + y?
; i.e. x is at most three times its valuation.
; Combined with positivity, this restricts the ratio x/v(x) to be at most 3.
; In base 2: v_2(x) = largest power of 2 dividing x, so x/v_2(x) is odd.
;   Smallest odd >=1 is 1, so x = v_2(x) satisfies this. SAT trivially.
; In any base: SAT (x = v_b(x) is always a solution — x is a pure power of the base).

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (<= x (+ y (+ y y)))
    (not (= x y))
  )
)
(check-sat)
