size01.koat_66
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_66.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it375 (* (- 2) it48) (* (- 1) i2)) 1)
                      (= (+ it376 (* (- 1) i3) (* 2 it48)) 0)
                      (= (+ it399 (* (- 1) it379) (* (- 1) (exp it376 2))
                         (* (- 1) (exp (+ (- 1) it376) 2))) 0)
                      (= (+ (* (- 8) (exp it48 3)) (* (- 6) i3 it48)
                         (* (- 6) it48 (exp i3 2)) (* (- 3) i6) (* (- 1) it48)
                         (* 3 it379) (* 6 (exp it48 2)) (* 12 i3 (exp it48 2))) 0)
                      (= (+ (* (- 1) i4 (exp (- 1) it48)) (* (- 1) it397)) 0)
                      (= (+ (* (- 1) i5 (exp (- 1) it48)) (* (- 1) it398)) 0)
                      (= (+ (* 2 it13) (* 2 it380)) 0)
                      (<= 1 it376)
                      (<= (+ (* (- 1) i3) (* 2 it48)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it48)) 1)
                      (<= (+ (* (- 1) it376) (* 2 it13)) (- 2))
                      (<= (+ (* (- 1) it376) (* 2 it13)) (- 1))
                      (<= (+ (* (- 1) it376) (* 2 it13) (* 2 it380)) (- 2))
                      (<= (+ (* (- 1) it376) (* 2 it13) (* 2 it380)) (- 1))
                      (<= (+ (* 2 it13) (* 2 it380)) 0)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it376) (- 2))
                      (<= (* (- 1) it380) (- 1))
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
    0) (exp it376 2)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) it376) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
