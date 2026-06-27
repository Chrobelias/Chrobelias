; Instance 30
; Meaning: Is there x, y, z, w, u, vv with:
;   v(x, y), v(z, w), v(u, vv),
;   12*x + 8*z = 27*u,
;   y + w = vv,
;   x <= z, z <= u?
; 12 = 4*3, 8 = 2^3, 27 = 3^3. The equation 12x + 8z = 27u is highly
; structured: left side divisible by 4 (base 2 sensitive), right side by 27 (base 3 sensitive).
; The constraint y + w = vv says: the valuation of u equals the sum of valuations of x and z.
; In base 2: v_2(27u) = v_2(u) = vv. v_2(12x) = 4*v_2(x) = 4y (if x power of 2, else different).
;   Actually v_2(12x+8z) is complex. Deep interaction.
; In base 3: v_3(12x) = v_3(x) = y (12 coprime to 3? No: 12=4*3, so v_3(12x)=3*v_3(x)=3y).
;   v_3(8z) = v_3(z) = w. v_3(27u) = 27*v_3(u) = 27*vv.
;   So vv = y + w, and 27*vv = 27y + 27w. Highly constrained. Likely UNSAT in base 3.
; In base 2: 27 is odd so v_2(27u)=v_2(u)=vv. Interesting.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(declare-fun u () Int)
(declare-fun vv () Int)
(assert
  (and
    (> x 0)
    (> z 0)
    (> u 0)
    (int.v x y)
    (int.v z w)
    (int.v u vv)
    (= (+ (* 12 x) (* 8 z)) (* 27 u))
    (= (+ y w) vv)
    (<= x z)
    (<= z u)
  )
)
(check-sat)
