(set-logic ALL)

(declare-const x Int)
(declare-const y Int)
(declare-const z Int)

(push 1)
  (assert (= x 5))
  (assert (= y 3))
  (assert (= (bwand x y) 1))
  (assert (= (bwor x y) 7))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (bwand x 1 ) 1))
  (assert (= x (* 2 y)))
  (check-sat) ; unsat
(pop 1)
