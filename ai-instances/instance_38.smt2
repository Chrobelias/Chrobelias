; Instance 38
; Meaning: A "valuation monotonicity" stress test.
; We want: whenever 4*x <= z, it is NOT the case that v(z) < v(x).
; I.e. if z is at least 4 times x, then z's valuation is at least x's valuation.
; We assert the negation: there exist x, z with 4*x <= z but v(z) < v(x).
; In base 2: z >= 4x means v_2(z) >= 4*v_2(x) in the best case, so UNSAT.
;   But z could be odd and large: z=5, x=1, 4<=5 ✓, v_2(5)=1=v_2(1). Not <.
;   z=3, x=1: 4>3, fails. z=7, x=1: v_2(7)=1, v_2(1)=1. Not <.
;   z=6, x=4: 16>6, fails. Hmm. z=9, x=2: 8<=9, v_2(9)=1 < v_2(2)=2. SAT in base 2!
; In base 3: z=10, x=3: 12>10. z=10, x=2: 8<=10, v_3(10)=1=v_3(2). Not <.
;   z=10, x=9: 36>10. z=28, x=7: 28<=28, v_3(28)=1 < v_3(7)=1. Equal, not <.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun z () Int)
(declare-fun vz () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (int.v x vx)
    (int.v z vz)
    (<= (* 4 x) z)
    (< vz vx)
  )
)
(check-sat)
