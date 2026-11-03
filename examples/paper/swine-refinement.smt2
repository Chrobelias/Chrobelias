; Sect. 6: SwInE gives no answer within 60 s; Chrobelias answers unsat at once.
(set-logic ALL)
(declare-fun x () Int)
(declare-fun y () Int)
(assert (= (+ (* 7 x) 3) (exp 2 y)))
(check-sat)
