; Instance 10
; Meaning: Are there x, y such that v(x, y) and y <= x and x <= y + y?
; i.e. x lies strictly between y and 2y (inclusive on both ends).
; This constrains x to be in the range [y, 2y].
; In base 2: y must be a power of 2, and x in [y, 2y]. E.g. y=2, x=2,3,4. v_2(3)=1 ≠ 2. 
;   x=2: v_2(2)=2=y. SAT. x=4: v_2(4)=4 ≠ 2.
; In base 3: y=1, x in [1,2]: v_3(1)=1, v_3(2)=1. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x y)
    (<= y x)
    (<= x (+ y y))
  )
)
(check-sat)
