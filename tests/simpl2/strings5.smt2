(set-logic QF_S)
(declare-const x String)
(declare-const y String)

(assert (= (str.++ "123" x) (str.++ y x)))
(assert (= "122" y))

(check-sat)

