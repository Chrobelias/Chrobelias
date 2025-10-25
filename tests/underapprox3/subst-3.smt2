(set-logic QF_S)

(declare-fun z () String)
(declare-fun x () Int)
(declare-fun y () Int)

(assert (= (str.substr "10" x y) "1"))
(assert (= y 1))
(assert (= x 0))
(set-info :status sat)
(check-sat)
