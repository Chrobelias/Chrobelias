; Instance 42
; Meaning: Valuation of a sum behaves differently depending on whether
; the two summands are "valuation-comparable".
; We assert: there exist x, y such that
;   EITHER v(x+y) > v(x) and v(x+y) > v(y)  (sum has strictly larger valuation)
;   OR     v(x+y) < v(x) and v(x+y) < v(y)  (sum has strictly smaller valuation)
; The first case (cancellation): x=1, y=-1... but we need positivity.
;   In base 2: x=2, y=2: v_2(4)=4 > v_2(2)=2. First disjunct. SAT.
; The second case is more surprising — is it ever possible?
; In base 2: v_2(x+y) < min(v_2(x), v_2(y)) seems impossible (ultrametric). 
;   So we'd only expect the first disjunct to fire.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun vx () Int)
(declare-fun vy () Int)
(declare-fun vs () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x vx)
    (int.v y vy)
    (int.v (+ x y) vs)
    (or
      (and (< vx vs) (< vy vs))
      (and (< vs vx) (< vs vy))
    )
  )
)
(check-sat)
