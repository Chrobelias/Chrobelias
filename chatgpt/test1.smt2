(set-logic QF_SLIA)

; Variables:
;   x,y,z  -- integer unknowns
;   u,v    -- valuations

(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun u () Int)
(declare-fun v () Int)

; Linear constraints.
(assert (= (+ (* 3 x) (* (- 2) y) z) 4))
(assert (<= (+ x y (* (- 2) z)) 3))
(assert (<= -2 (+ (* 2 x) y)))

; u is the largest power of the base dividing
;     2*x - y.
(assert (int.v (+ (* 2 x) (* (- 1) y)) u))

; v is the largest power of the base dividing
;     z + 1.
(assert (int.v (+ z 1) v))

; The valuation of z+1 is at least the valuation of 2*x-y.
(assert (<= u v))

(check-sat)