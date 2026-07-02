; discrete_log_18.smt2
; a = 720, c = 2 (ceil(2*720/3) = 480, c in [2,480], chosen c=2)
; int.v(x,x): x is a power of the base.
; 720*y = x - z, 0 <= z <= 2. 720 = 6! = 2^4 * 3^2 * 5.
; x mod 720 in [0, 2]. Highly composite modulus, very tight window.
; In base 2: 2^0=1✓,2^1=2✓. SAT.
; In base 3: 3^1=3>2. 3^0=1✓. SAT.
; In base 719 (prime): 719 mod 720=719>2. 719^0=1✓. SAT.
; The highly composite 720 makes the residue sequence of any base very structured.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 720 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
