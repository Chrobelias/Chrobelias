(set-logic ALL)
(set-info :source |
https://en.wikipedia.org/wiki/Power_of_two#Last_digits_for_powers_of_two_whose_exponents_are_powers_of_two
|)
(set-info :status sat)

(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)

(assert (= (exp 2 x) y))
(assert (= (exp 2 y) z))
(assert (exists ((k Int)) (= (+ 36 (* 100 k)) z)))

(check-sat)
(get-model)