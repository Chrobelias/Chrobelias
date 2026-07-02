; discrete_log_23.smt2
; a = 900, c = 300 (ceil(2*900/3) = 600, c in [2,600], chosen c=300)
; int.v(x,x): x is a power of the base.
; 900*y = x - z, 0 <= z <= 300.
; x mod 900 in [0, 300]. Exactly 1/3 of residues.
; In base 2: 2^8=256✓. SAT.
; In base 3: 3^5=243✓. SAT.
; In base 5: 5^3=125✓,5^4=625>300. 5^5=3125 mod 900=425>300. 5^6 mod 900=25✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 900 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 300))
(check-sat)
