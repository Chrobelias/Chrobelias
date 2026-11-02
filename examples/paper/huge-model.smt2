; Sect. 4: Chrobelias answers sat with "no short model"; SwInE answers unknown (exponent-overflow).
(set-logic ALL)
(declare-fun x () Int)
(declare-fun z () Int)
(assert (>= z (+ x (exp 2 x) (exp 2 (exp 2 x)))))
(assert (>= x 100))
(check-sat)
(get-model)
