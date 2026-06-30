; Instance 51
; Meaning: Is there x > 0 with v(x, y) such that y is sandwiched between
; two large multiples of itself: 100*y <= x <= 1000*y?
; I.e. x is between 100 and 1000 times its own valuation.
; In base 2: x/v_2(x) is always odd, so this asks for an odd number in [100,1000].
;   E.g. x = 101 * 1 = 101 (odd), v_2(101)=1, 100<=101<=1000. SAT.
; In base 3: x/v_3(x) is never divisible by 3. Many solutions exist. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (<= (* 100 y) x)
    (<= x (* 1000 y))
  )
)
(check-sat)
