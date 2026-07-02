; discrete_log_25.smt2
; a = 997, c = 400 (997 is prime, ceil(2*997/3) = 665, c in [2,665], chosen c=400)
; int.v(x,x): x is a power of the base.
; 997*y = x - z, 0 <= z <= 400.
; x mod 997 in [0, 400]. Just under half the residues.
; In base 2: by Fermat ord_997(2) | 996. 2^10=1024 mod 997=27✓. SAT.
; In base 3: 3^6=729>400. 3^5=243✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 997 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 400))
(check-sat)
