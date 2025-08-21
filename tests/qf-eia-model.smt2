(set-logic ALL)

(declare-const x1 Int)
(declare-const x2 Int)

(push 1)
    (assert (= x2 (+ 3 (exp 2 x1))))
    (assert (>= x2 200))
    (check-sat)
    (get-model)
(pop 1)
