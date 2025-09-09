size01.koat_64
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_64.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i3
    1) it48
    
  Non linear arithmetic between
    0) i3
    1) (exp it48 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it48)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it48)
    
  Non linear arithmetic between
    0) it48
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  Leftover formula:
  (and
                      (= (+ it375 (* (- 2) it48) (* (- 1) i2)) 1)
                      (= (+ it376 (* (- 1) i3) (* 2 it48)) 0)
                      (= (+ it377 (* (- 1) i4 (exp (- 1) it48))) 0)
                      (= (+ it378 (* (- 1) i5 (exp (- 1) it48))) 0)
                      (= (+ (* (- 8) (exp it48 3)) (* (- 6) i3 it48)
                         (* (- 6) it48 (exp i3 2)) (* (- 3) i6) (* (- 1) it48)
                         (* 3 it379) (* 6 (exp it48 2)) (* 12 i3 (exp it48 2))) 0)
                      (<= 1 it376)
                      (<= (+ (* (- 1) i3) (* 2 it48)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it48)) 1)
                      (<= (* (- 1) it376) (- 2))
                      (<= (* (- 1) it48) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it48
    
  Non linear arithmetic between
    0) i3
    1) (exp it48 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it48)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it48)
    
  Non linear arithmetic between
    0) it48
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
