; discrete_log_15.smt2
; a = 512, c = 2 (ceil(2*512/3) = 342, c in [2,342], chosen c=2)
; int.v(x,x): x is a power of the base.
; 512*y = x - z, 0 <= z <= 2. 512 = 2^9.
; x mod 512 in [0, 2]. Tightest possible window with c=2.
; In base 2: 2^0=1✓,2^1=2✓,2^9=512≡0✓,2^10=1024≡0✓. SAT (and many solutions).
; In base 3: 3^1=3>2. 3^0=1✓. SAT.
; In base 511: 511 mod 512=511>2. 511^0=1✓. SAT.
; Very interesting in base 2 since 512 = 2^9 means all powers >= 2^9 have residue 0.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 512 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
