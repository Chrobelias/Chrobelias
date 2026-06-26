; Instance 14
; Meaning: Is there x > 0 such that v(x+x+x+x, y) and y = x?
; i.e. 4*x has valuation exactly x.
; In base 2: v_2(4x) = v_2(x) * 4 (if x is a power of 2). 
;   So we need v_2(4x) = x. E.g. x=4: v_2(16)=16, y=16 ≠ 4. 
;   x=1: v_2(4)=4 ≠ 1. Likely UNSAT in base 2.
; In base 3: v_3(4x) = v_3(x) (since gcd(4,3)=1).
;   So we need v_3(x) = x. E.g. x=1: v_3(4)=1=x. SAT!

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (int.v (+ x (+ x (+ x x))) y)
    (= y x)
  )
)
(check-sat)
