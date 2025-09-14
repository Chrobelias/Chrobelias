(set-logic ALL)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
 
(assert (and
          (= (* (exp 2 z) (+ 1 (exp 2 u))) y)
          (<= y 20)
          (>= z 1)
          (>= (exp 2 u) 3)
          ))
(check-sat)