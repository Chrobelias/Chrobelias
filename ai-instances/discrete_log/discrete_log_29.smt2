; discrete_log_29.smt2
; a = 729, c = 2 (729 = 3^6, ceil(2*729/3) = 486, c in [2,486], chosen c=2)
; int.v(x,x): x is a power of the base.
; 729*y = x - z, 0 <= z <= 2. 729 = 3^6.
; x mod 729 in [0, 2].
; In base 3: 3^0=1✓,3^1=3>2. 3^6=729≡0✓,3^7≡0✓,... all powers >= 6 give residue 0. SAT.
; In base 2: 2^0=1✓,2^1=2✓. SAT.
; Very interesting in base 3: since 729=3^6, all powers of 3 at exponent >= 6 
; are divisible by 729, landing at residue 0. Mirrors the base-2 behavior of discrete_log_9/15.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 729 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
