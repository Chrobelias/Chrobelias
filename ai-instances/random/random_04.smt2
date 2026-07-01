; Instance 25
; Meaning: Is there x, y, z, w with:
;   v(x, y), v(z, w),
;   9*x = 16*z, y <= w?
; 9 = 3^2 and 16 = 2^4. The equation 9x = 16z forces a very specific
; relationship between x and z. Their valuations must also satisfy y <= w.
; In base 2: 9 is odd, so v_2(9x) = v_2(x) = y. 16 = 2^4, so v_2(16z) = 16*v_2(z) = 16w.
;   Wait: v_2(16z) = v_2(z) * 16 only if z is a power of 2. In general v_2(16z) = v_2(z) + ... 
;   Actually v_2(16z) = v_2(z) * 16 is wrong; correct: if v_2(z) = w then v_2(16z) = 16w.
;   Hmm: v_2(16z) = largest power of 2 dividing 16z.
;   So y = 16w (from 9x=16z and base-2 valuation). But y <= w means 16w <= w, impossible for w>0. 
;   UNSAT in base 2.
; In base 3: v_3(9x) = 9*v_3(x) = 9y. v_3(16z) = v_3(z) = w (16 coprime to 3).
;   So 9y = w, and y <= w = 9y. Always true for y>0. SAT if 9x=16z has a solution.
;   x=16, z=9: 9*16=144=16*9. v_3(16)=1=y, v_3(9)=9=w. y<=w: 1<=9. SAT!

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
    (= (* 9 x) (* 16 z))
    (<= y w)
  )
)
(check-sat)
