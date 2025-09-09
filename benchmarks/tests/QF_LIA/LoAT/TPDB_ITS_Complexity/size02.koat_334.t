size02.koat_334
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_334.smt2 || echo TIMEOUT
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
    0) it1184
    1) it13
    
  Non linear arithmetic between
    0) it1184
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) it1185
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it1186
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp it1184 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it1184 2)
    
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
                      (= (+ it1183 (* (- 2) it92) (* (- 1) i2)) 1)
                      (= (+ it1184 (* (- 1) i3) (* 2 it92)) 0)
                      (= (+ it1185 (* (- 1) i4 (exp (- 1) it92))) 0)
                      (= (+ it1186 (* (- 1) i5 (exp (- 1) it92))) 0)
                      (= (+ it1469 (* (- 2) it13) (* (- 1) it1183)) 0)
                      (= (+ it1470 (* (- 1) it1184) (* 2 it13)) 0)
                      (= (+ it1471 (* (- 1) it1185 (exp (- 1) it13))) 0)
                      (= (+ it1472 (* (- 1) it1186 (exp (- 1) it13))) 0)
                      (= (+ (* (- 8) (exp it13 3)) (* (- 6) it1184 it13)
                         (* (- 6) it13 (exp it1184 2)) (* (- 3) it1187)
                         (* (- 1) it13) (* 3 it1473) (* 6 (exp it13 2))
                         (* 12 it1184 (exp it13 2))) 0)
                      (= (+ (* (- 8) (exp it92 3)) (* (- 6) i3 it92)
                         (* (- 6) it92 (exp i3 2)) (* (- 3) i6) (* (- 1) it92)
                         (* 3 it1187) (* 6 (exp it92 2))
                         (* 12 i3 (exp it92 2))) 0)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 1)
                      (<= (+ (* (- 1) it1184) (* 2 it13)) 0)
                      (<= (+ (* (- 1) it1184) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it1470) (* 2 it1188)) 0)
                      (<= (+ (* (- 1) it1470) (* 2 it1188)) 1)
                      (<= (+ (* (- 1) it1470) (* 2 it1188) (* 2 it1474)) 0)
                      (<= (+ (* (- 1) it1470) (* 2 it1188) (* 2 it1474)) 1)
                      (<= (+ (* 2 it1188) (* 2 it1474)) 0)
                      (<= (* (- 1) it1188) (- 1))
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it1474) (- 1))
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
    0) it1184
    1) it13
    
  Non linear arithmetic between
    0) it1184
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) it1185
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it1186
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp it1184 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it1184 2)
    
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
