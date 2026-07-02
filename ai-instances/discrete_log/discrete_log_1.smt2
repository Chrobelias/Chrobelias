; discrete_log_1.smt2
; a = 75, c = 2 (ceil(2*75/3) = 50, c in [2,50], chosen c=2)
; int.v(x,x): x is a power of the base.
; 75*y = x - z, 0 <= z <= 2.
; x mod 75 must lie in [0, 2]. Very tight window.
; In base 2: powers of 2 mod 75: 1,2,4,8,16,32,64,53,31,62,49,23,46,17,34,68,61,47,19,38,1,...
;   Period 20. Values in [0,2]: 1 (2^0), 2 (2^1). SAT.
; In base 3: powers of 3 mod 75: 1,3,9,27,6,18,54,12,36,33,24,72,66,48,69,57,21,63,39,42,51,3,...
;   Value 1 (3^0) in [0,2]. SAT.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(assert (int.v x x))
(assert (= (* 75 y) (- x z)))
(assert (<= 0 z))
(assert (<= z 2))
(check-sat)
