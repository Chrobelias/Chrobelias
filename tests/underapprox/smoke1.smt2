(set-logic ALL)
(declare-fun x1 () Int)
(declare-fun x2 () Int)

(assert (>= x1 0))
(assert (>= x2 0))
(assert (<= (+
            (* 77 (exp 2 x1))
            (* 42 (exp 2 x2))
            (* 575 x2)
            (* (- 575) x1))
           (- 80)))
(check-sat)