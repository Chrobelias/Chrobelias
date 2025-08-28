size10.koat_4
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_4.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it17 (* (- 2) it15) (* (- 1) i2)) 1)
                      (= (+ it18 (* (- 1) i3) (* 2 it15)) 0)
                      (= (+ it19 (* (- 1) i4 (exp (- 1) it15))) 0)
                      (= (+ it20 (* (- 1) i5 (exp (- 1) it15))) 0)
                      (= (+ (* (- 8) (exp it15 3)) (* (- 6) i3 it15)
                         (* (- 6) it15 (exp i3 2)) (* (- 3) i6) (* (- 1) it15)
                         (* 3 it21) (* 6 (exp it15 2)) (* 12 i3 (exp it15 2))) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= (+ (* (- 1) i3) (* 2 it15)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it15)) 1)
                      (<= (* (- 1) it15) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it15
    
  Non linear arithmetic between
    0) i3
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it15
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it15 2)
    
  Non linear arithmetic between
    0) (exp it15 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
