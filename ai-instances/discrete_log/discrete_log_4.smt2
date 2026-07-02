; discrete_log_4.smt2
; a = 100, c = 35 (ceil(2*100/3) = 67, c in [2,67], chosen c=35)
; int.v(x,x): x is a power of the base.
; 100*y = x - z, 0 <= z <= 35.
; x mod 100 in [0, 35].
; In base 2: powers of 2 mod 100 in [0,35]: 1,2,4,8,16,32,28,... 
;   2^0=1✓,2^1=2✓,2^2=4✓,2^3=8✓,2^4=16✓,2^5=32✓. SAT easily.
; In base 7: 7^1=7✓,7^2=49>35,7^3=343≡43>35,7^4≡1✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 100 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 35))
(check-sat)
