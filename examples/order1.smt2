(set-logic QF_S)

(declare-const b String)
(declare-const x Int)
(declare-const y Int)

(assert (= (str.to.int b) y))
(assert (= 1 (+ (* x (exp 10 u)) y)))
(assert (= (str.len b) u))
(check-sat)