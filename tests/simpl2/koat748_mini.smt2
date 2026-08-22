(set-logic ALL)
(declare-fun it1095 () Int)
(declare-fun it1118 () Int)
(declare-fun it1126 () Int)

(declare-fun it1141 () Int)
(declare-fun it1142 () Int)
(declare-fun it1143 () Int)
(declare-fun it57 () Int)
(declare-fun it134 () Int)

(assert
  (>= (+ 2
        (* (- 1) it1095 (** 2 (+ it134 (- 1))))
        (* (- 1) (** 2 it134) ))
        0)
       )
(assert (= (+ it1118 (- 1)) 0)) ;
(assert (= (+ it1126 (* it1118 (- 1))) 0)) ;
(assert (= (+ (* it1126 (- 2)) it1143) 0)) ;
(assert
  (and ;(>= (+ it57 (- 1)) 0) ; commenting this gives crash without pre-simpl
       (>= (+ it1141 (* it1143 (** 2 (- it57 1)) (- 1)) (- 1)) 0) ;
       ))
(check-sat)
