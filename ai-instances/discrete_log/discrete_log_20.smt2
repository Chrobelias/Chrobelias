; discrete_log_20.smt2
; a = 810, c = 4 (ceil(2*810/3) = 540, c in [2,540], chosen c=4)
; int.v(x,x): x is a power of the base.
; 810*y = x - z, 0 <= z <= 4. 810 = 2 * 3^4 * 5.
; x mod 810 in [0, 4]. Very tight.
; In base 2: 2^0=1✓,2^1=2✓,2^2=4✓. SAT.
; In base 3: 3^1=3✓. SAT.
; In base 5: 5>4. 5^0=1✓. SAT.
; In base 809 (prime): 809 mod 810=809>4. 809^0=1✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 810 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 4))
(check-sat)
