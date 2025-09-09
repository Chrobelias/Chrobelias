size03.koat_26
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_26.smt2 || echo TIMEOUT
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
    0) it127
    1) it16
    
  Non linear arithmetic between
    0) it127
    1) (exp it16 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) it16
    1) (exp it127 2)
    
  Non linear arithmetic between
    0) it17
    1) (exp (- 1) it127)
    
  Non linear arithmetic between
    0) it18
    1) (exp (- 1) it127)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it127 2)
    
  Non linear arithmetic between
    0) (exp it127 3)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it16 2)
    
  Leftover formula:
  (and
                      (= (+ it129 (* (- 2) it127) (* (- 1) it15)) 0)
                      (= (+ it130 (* (- 1) it16) (* 2 it127)) 0)
                      (= (+ it131 (* (- 1) it17 (exp (- 1) it127))) 0)
                      (= (+ it132 (* (- 1) it18 (exp (- 1) it127))) 0)
                      (= (+ it15 (* (- 2) it13) (* (- 1) i2)) 1)
                      (= (+ it16 (* (- 1) i3) (* 2 it13)) 0)
                      (= (+ it17 (* (- 1) i4 (exp (- 1) it13))) 0)
                      (= (+ it18 (* (- 1) i5 (exp (- 1) it13))) 0)
                      (= (+ (* (- 8) (exp it127 3)) (* (- 6) it127 it16)
                         (* (- 6) it127 (exp it16 2)) (* (- 3) it19)
                         (* (- 1) it127) (* 3 it133) (* 6 (exp it127 2))
                         (* 12 it16 (exp it127 2))) 0)
                      (= (+ (* (- 8) (exp it13 3)) (* (- 6) i3 it13)
                         (* (- 6) it13 (exp i3 2)) (* (- 3) i6) (* (- 1) it13)
                         (* 3 it19) (* 6 (exp it13 2)) (* 12 i3 (exp it13 2))) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it16) (* 2 it127)) 0)
                      (<= (+ (* (- 1) it16) (* 2 it127)) 1)
                      (<= (* (- 1) it127) (- 1))
                      (<= (* (- 1) it13) (- 1)))
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
    0) it127
    1) it16
    
  Non linear arithmetic between
    0) it127
    1) (exp it16 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) it16
    1) (exp it127 2)
    
  Non linear arithmetic between
    0) it17
    1) (exp (- 1) it127)
    
  Non linear arithmetic between
    0) it18
    1) (exp (- 1) it127)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it127 2)
    
  Non linear arithmetic between
    0) (exp it127 3)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it16 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
