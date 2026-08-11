(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)

(assert (= w 7))
(assert (= x (+ y 1)))
(assert (= z (+ x 1)))
(assert (= w (+ z 1)))
(assert (< w 3))
(assert (= y 7))

(check-sat)
