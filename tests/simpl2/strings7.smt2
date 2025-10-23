(set-logic QF_S)

(declare-const x String)
(declare-const y Int)
(declare-const z Int)

(assert (>= (str.to.int x) 10))
(assert (>= (str.to.int y) 10))
(assert (>= (str.to.int z) 10))

(assert (= (str.++ x y) z))

(check-sat)