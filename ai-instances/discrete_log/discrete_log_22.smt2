; discrete_log_22.smt2
; a = 900, c = 3 (ceil(2*900/3) = 600, c in [2,600], chosen c=3)
; int.v(x,x): x is a power of the base.
; 900*y = x - z, 0 <= z <= 3. 900 = 4 * 9 * 25 = 2^2 * 3^2 * 5^2.
; x mod 900 in [0, 3]. Highly composite modulus, tiny window.
; In base 2: 2^0=1✓,2^1=2✓. SAT.
; In base 3: 3^1=3✓. SAT.
; In base 4: 4>3. 4^0=1✓. SAT.
; The square structure of 900 = 30^2 makes the orbit of any base mod 900 interesting.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 900 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 3))
(check-sat)
