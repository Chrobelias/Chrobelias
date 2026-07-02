; discrete_log_3.smt2
; a = 100, c = 2 (ceil(2*100/3) = 67, c in [2,67], chosen c=2)
; int.v(x,x): x is a power of the base.
; 100*y = x - z, 0 <= z <= 2.
; x mod 100 in [0, 2]: only residues 0, 1, 2.
; In base 2: powers of 2 mod 100: 1,2,4,8,16,32,64,28,56,12,24,48,96,92,84,68,36,72,44,88,76,52,4,...
;   Values in [0,2]: 1 (2^0=1), 2 (2^1=2). SAT.
; In base 10: powers of 10 mod 100: 10,100≡0,0,0... 10 not in [0,2]. 1 (10^0) ∈ [0,2]. SAT.
; Very tight constraint.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 100 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
