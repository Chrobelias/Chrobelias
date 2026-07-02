; discrete_log_24.smt2
; a = 997, c = 2 (997 is prime, ceil(2*997/3) = 665, c in [2,665], chosen c=2)
; int.v(x,x): x is a power of the base.
; 997*y = x - z, 0 <= z <= 2.
; x mod 997 in [0, 2]. 997 is prime — the orbit of any base mod 997 has length dividing 996.
; In base 2: 2^0=1✓,2^1=2✓. SAT.
; In base 3: 3^1=3>2. 3^0=1✓. SAT.
; The primality of 997 means the multiplicative group mod 997 is cyclic of order 996=4*3*83.
; Reaching residues 0,1,2 via powers is an interesting discrete log problem.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 997 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
