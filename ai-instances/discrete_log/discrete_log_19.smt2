; discrete_log_19.smt2
; a = 720, c = 240 (ceil(2*720/3) = 480, c in [2,480], chosen c=240)
; int.v(x,x): x is a power of the base.
; 720*y = x - z, 0 <= z <= 240.
; x mod 720 in [0, 240]. Exactly 1/3 of residues allowed.
; 720 = 2^4 * 3^2 * 5. The window [0,240] = [0, 720/3].
; In base 2: 2^7=128✓,2^8=256>240. 2^9=512>240. 2^10=1024 mod 720=304>240.
;   2^11=2048 mod 720=608>240. 2^12=4096 mod 720=496>240. 2^13 mod 720=272>240.
;   2^14 mod 720=544>240. 2^15 mod 720=368>240. 2^16 mod 720=16✓. SAT.
; In base 3: 3^4=81✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 720 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 240))
(check-sat)
