; discrete_log_8.smt2
; a = 200, c = 100 (ceil(2*200/3) = 134, c in [2,134], chosen c=100)
; int.v(x,x): x is a power of the base.
; 200*y = x - z, 0 <= z <= 100.
; x mod 200 in [0, 100]. Half the residues allowed.
; In base 2: 2^7=128>100 mod 200=128>100. 2^6=64✓. SAT.
; In base 3: 3^4=81✓. SAT.
; In base 199: 199 mod 200=199>100. 199^2=39601 mod 200=1✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 200 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 100))
(check-sat)
