; discrete_log_26.smt2
; a = 1000, c = 2 (ceil(2*1000/3) = 667, c in [2,667], chosen c=2)
; int.v(x,x): x is a power of the base.
; 1000*y = x - z, 0 <= z <= 2. 1000 = 2^3 * 5^3.
; x mod 1000 in [0, 2]. The last 3 decimal digits of x^k must be 000, 001, or 002.
; In base 2: 2^0=1✓,2^1=2✓. SAT. 
; In base 10: 10^3=1000≡0✓,10^4≡0✓,... all powers >= 3 give 0. SAT.
; In base 5: 5^4=625>2. 5^0=1✓. SAT.
; Interesting: in base 10, ALL sufficiently large powers end in 000.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 1000 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
