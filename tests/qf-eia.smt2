(set-logic ALL)

(declare-const x Int)
(declare-const y Int)

(push 1)
  (assert (= (exp 2 x) 16))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (exp 2 x) 17))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= (+ (exp 2 x) 4) 16))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= (exp 2 x) (exp 2 y)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (exp 2 x) (+ (exp 2 y) 5)))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= (+ (exp 2 x) x) 6))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (+ (exp 2 x) x) 5))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= x y))
  (assert (not (= (exp 2 x) (exp 2 y))))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (not (= x y)))
  (assert (= (exp 2 x) (exp 2 y)))
  (assert (>= x 0))
  (assert (>= y 0))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= x y))
  (assert (= (exp 2 x) (exp 2 y)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (exp 2 x) (+ (exp 2 y) 5)))
  (check-sat) ; unsat
(pop 1)

(push 1)
    (assert (> x 10))
    (assert (= (exp 2 x) (exp 2 y)))
    (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= x (+ y 1)))
  (assert (not (= (exp 2 x) (* 2 (exp 2 y)))))
  (check-sat) ; unsat
(pop 1)
