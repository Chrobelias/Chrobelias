size04.koat_224
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_224.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i3
    1) it92
    
  Non linear arithmetic between
    0) i3
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it1065
    1) it13
    
  Non linear arithmetic between
    0) it1065
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) it1066
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it1067
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp it1065 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it1065 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  Leftover formula:
  (and
                      (= (+ it1064 (* (- 2) it92) (* (- 1) i2)) 1)
                      (= (+ it1065 (* (- 1) i3) (* 2 it92)) 0)
                      (= (+ it1066 (* (- 1) i4 (exp (- 1) it92))) 0)
                      (= (+ it1067 (* (- 1) i5 (exp (- 1) it92))) 0)
                      (= (+ it1084 (* (- 2) it13) (* (- 1) it1064)) 0)
                      (= (+ it1085 (* (- 1) it1065) (* 2 it13)) 0)
                      (= (+ it1086 (* (- 1) it1066 (exp (- 1) it13))) 0)
                      (= (+ it1087 (* (- 1) it1067 (exp (- 1) it13))) 0)
                      (= (+ (* (- 8) (exp it13 3)) (* (- 6) it1065 it13)
                         (* (- 6) it13 (exp it1065 2)) (* (- 3) it1068)
                         (* (- 1) it13) (* 3 it1088) (* 6 (exp it13 2))
                         (* 12 it1065 (exp it13 2))) 0)
                      (= (+ (* (- 8) (exp it92 3)) (* (- 6) i3 it92)
                         (* (- 6) it92 (exp i3 2)) (* (- 3) i6) (* (- 1) it92)
                         (* 3 it1068) (* 6 (exp it92 2))
                         (* 12 i3 (exp it92 2))) 0)
                      (= (+ (* 2 it1069) (* 2 it1089)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 1)
                      (<= (+ (* (- 1) it1065) (* 2 it13)) 0)
                      (<= (+ (* (- 1) it1065) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it1085) (* 2 it1069)) 0)
                      (<= (+ (* (- 1) it1085) (* 2 it1069)) 1)
                      (<= (+ (* (- 1) it1085) (* 2 it1069) (* 2 it1089)) 0)
                      (<= (+ (* (- 1) it1085) (* 2 it1069) (* 2 it1089)) 1)
                      (<= (+ (* 2 it1069) (* 2 it1089)) 0)
                      (<= (* (- 1) it1069) (- 1))
                      (<= (* (- 1) it1089) (- 1))
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it92
    
  Non linear arithmetic between
    0) i3
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it1065
    1) it13
    
  Non linear arithmetic between
    0) it1065
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) it1066
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it1067
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp it1065 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it1065 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
