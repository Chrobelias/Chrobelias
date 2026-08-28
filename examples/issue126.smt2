(set-logic QF_EIA)
(declare-fun u () Int)
(declare-fun y () Int)
(declare-fun z () Int)
 
(assert (and
          (= (* (** 2 z) (+ 1 (** 2 u))) y)
          (<= y 20)
          (>= z 1)
          (>= (** 2 u) 3)
          ))
(check-sat)