(set-logic ALL)

(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun u () Int)
(declare-fun v () Int)

(assert (= (** 2 x) y))
(assert (= (** 2 (+ x (- 1))) z))
(assert (= (** 2 (+ x (- 3))) u))
(assert (= (** 2 (+ x (- 5))) v))

(assert (>= (+ x y z u v) 100))

(check-sat)
