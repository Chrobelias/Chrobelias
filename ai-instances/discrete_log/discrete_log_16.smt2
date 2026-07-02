; discrete_log_16.smt2
; a = 600, c = 50 (ceil(2*600/3) = 400, c in [2,400], chosen c=50)
; int.v(x,x): x is a power of the base.
; 600*y = x - z, 0 <= z <= 50.
; x mod 600 in [0, 50].
; In base 2: 2^0=1✓,...,2^5=32✓,2^6=64>50. 2^9=512>50. 2^10=1024 mod 600=424>50.
;   2^11=2048 mod 600=248>50. 2^12=4096 mod 600=496>50. 2^13=8192 mod 600=392>50.
;   2^14=16384 mod 600=184>50. 2^15=32768 mod 600=368>50. 2^16=65536 mod 600=136>50.
;   2^17 mod 600=272>50. 2^18 mod 600=544>50. 2^19 mod 600=488>50. 2^20 mod 600=376>50.
;   2^21 mod 600=152>50. 2^22 mod 600=304>50. 2^23 mod 600=8✓. SAT (at 2^23 for base 2).
; In base 3: 3^3=27✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 600 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 50))
(check-sat)
