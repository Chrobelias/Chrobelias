; discrete_log_30.smt2
; a = 50, c = 2 (ceil(2*50/3) = 34, c in [2,34], chosen c=2)
; int.v(x,x): x is a power of the base.
; 50*y = x - z, 0 <= z <= 2. 50 = 2 * 5^2.
; x mod 50 in [0, 2]. Smallest allowed a with tightest c.
; In base 2: 2^0=1✓,2^1=2✓. SAT.
; In base 3: 3^1=3>2. 3^0=1✓. SAT.
; In base 7: 7^2=49>2. 7^0=1✓. SAT.
; In base 50: 50≡0✓. SAT.
; In base 51: 51 mod 50=1✓. SAT.
; The smallest a=50 instance: useful as a baseline for solvers.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 50 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
