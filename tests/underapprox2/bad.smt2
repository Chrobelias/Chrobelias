(set-logic ALL)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)

(assert (and
           (= (+ (* 5 (** 2 z)) (** 2 (+ x z))) y)
           (<= y 1000000)
;           (<= 10 z)
;           (<= (* (- 1) (** 2 x)) (- 989))
))
(check-sat)