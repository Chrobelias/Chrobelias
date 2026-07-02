; discrete_log_9.smt2
; a = 256, c = 3 (ceil(2*256/3) = 171, c in [2,171], chosen c=3)
; int.v(x,x): x is a power of the base.
; 256*y = x - z, 0 <= z <= 3.
; x mod 256 in [0, 3]. 256 = 2^8.
; In base 2: powers of 2 mod 256: 1,2,4,8,... All powers of 2 up to 128 are > 3 except 1 and 2.
;   2^0=1✓, 2^1=2✓. SAT.
; In base 2: note 256 = 2^8, so 2^8 mod 256 = 0, 2^9 mod 256 = 0,... all higher powers ≡ 0 ∈ [0,3]! 
;   So infinitely many solutions in base 2. Very interesting.
; In base 3: 3 mod 256=3✓. SAT.
; In base 5: 5 mod 256=5>3. 5^2=25>3. 5^0=1✓. 

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 256 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 3))
(check-sat)
