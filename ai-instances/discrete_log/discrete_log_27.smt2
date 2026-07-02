; discrete_log_27.smt2
; a = 1000, c = 400 (ceil(2*1000/3) = 667, c in [2,667], chosen c=400)
; int.v(x,x): x is a power of the base.
; 1000*y = x - z, 0 <= z <= 400.
; x mod 1000 in [0, 400]. Last 3 digits of x in [000, 400].
; In base 2: 2^8=256✓,2^9=512>400. 2^10=1024 mod 1000=24✓. SAT.
; In base 3: 3^6=729>400. 3^5=243✓. SAT.
; In base 7: 7^3=343✓. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 1000 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 400))
(check-sat)
