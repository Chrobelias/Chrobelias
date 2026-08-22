(set-logic ALL)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun t () Int)
  
(assert (= (** 2 x) y))
(assert (= (** 2 y) z))
(assert (= (mod (+ z x y) 100) 67)) 

(check-sat)
(get-model)
