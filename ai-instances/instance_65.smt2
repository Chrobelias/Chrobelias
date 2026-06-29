; Instance 65
; Meaning: x is very large relative to its valuation vx, but the valuation
; of 6*x is forced into a narrow window around a large constant.
; 6 = 2*3 makes this base-sensitive: in base 2, v_2(6x) = v_2(x);
; in base 3, v_3(6x) = 3*v_3(x).
; The window [999999, 1000001] around 10^6 is extremely tight.
; Or-branch: either vx >= 999999 or vx6 >= 999999.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(declare-fun vx6 () Int)
(assert
  (and
    (> x 0)
    (int.v x vx)
    (int.v (+ x (+ x (+ x (+ x (+ x x))))) vx6)
    (<= (* 1000 vx) x)
    (<= 999999 vx6)
    (<= vx6 1000001)
    (or (<= 999999 vx) (<= 999999 vx6))
  )
)
(check-sat)
