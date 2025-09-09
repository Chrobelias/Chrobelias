size02.koat_26
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_26.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i3
    1) it13
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) it16
    1) it92
    
  Non linear arithmetic between
    0) it16
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) it17
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it18
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it92
    1) (exp it16 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it16 2)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  Leftover formula:
  (and
                      (= (+ it15 (* (- 2) it13) (* (- 1) i2)) 1)
                      (= (+ it16 (* (- 1) i3) (* 2 it13)) 0)
                      (= (+ it17 (* (- 1) i4 (exp (- 1) it13))) 0)
                      (= (+ it18 (* (- 1) i5 (exp (- 1) it13))) 0)
                      (= (+ it94 (* (- 2) it92) (* (- 1) it15)) 0)
                      (= (+ it95 (* (- 1) it16) (* 2 it92)) 0)
                      (= (+ it96 (* (- 1) it17 (exp (- 1) it92))) 0)
                      (= (+ it97 (* (- 1) it18 (exp (- 1) it92))) 0)
                      (= (+ (* (- 8) (exp it13 3)) (* (- 6) i3 it13)
                         (* (- 6) it13 (exp i3 2)) (* (- 3) i6) (* (- 1) it13)
                         (* 3 it19) (* 6 (exp it13 2)) (* 12 i3 (exp it13 2))) 0)
                      (= (+ (* (- 8) (exp it92 3)) (* (- 6) it16 it92)
                         (* (- 6) it92 (exp it16 2)) (* (- 3) it19)
                         (* (- 1) it92) (* 3 it98) (* 6 (exp it92 2))
                         (* 12 it16 (exp it92 2))) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it16) (* 2 it92)) 0)
                      (<= (+ (* (- 1) it16) (* 2 it92)) 1)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it13
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) it16
    1) it92
    
  Non linear arithmetic between
    0) it16
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) it17
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it18
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it92
    1) (exp it16 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it16 2)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
