(set-logic QF_S)

(declare-fun z () String)
(declare-fun x () Int)
(declare-fun y () Int)

(assert (= (str.substr "10" x y) "10"))
(assert (= y 2))
(assert (= x 0))
(check-sat)