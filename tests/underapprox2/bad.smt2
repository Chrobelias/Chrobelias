(set-logic ALL)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)

(assert (and
           (= (+ (* 5 (exp 2 z)) (exp 2 (+ u7 z))) y)
           (<= y 1000000)
;           (<= 10 z)
;           (<= (* (- 1) (exp 2 u7)) (- 989))
))
(check-sat)