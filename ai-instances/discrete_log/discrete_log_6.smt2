; discrete_log_6.smt2
; a = 150, c = 2 (ceil(2*150/3) = 100, c in [2,100], chosen c=2)
; int.v(x,x): x is a power of the base.
; 150*y = x - z, 0 <= z <= 2.
; x mod 150 in [0, 2]. Very tight.
; In base 2: 2^0=1✓, 2^1=2✓. SAT.
; In base 149: 149^1=149 mod 150=149>2. 149^0=1✓. SAT (trivially via x=1).
; In base 151: 151 mod 150=1✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 150 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
