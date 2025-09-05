(set-logic ALL)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)

(assert (>= z 5))
(assert (>= x 37))
(assert (= (* x (exp 2 z)) y))
(assert (<= y 1184))
(check-sat) ; z=5, x=2^5+5, y = (32+5)*32 = 1184