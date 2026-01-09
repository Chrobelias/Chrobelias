(set-logic QF_S)

(declare-fun z () String)
(declare-fun x () Int)
(declare-fun y () Int)

(assert (= (str.substr "ab" x y) "a"))
(assert (= y 1))
(assert (= x 0))
(check-sat)