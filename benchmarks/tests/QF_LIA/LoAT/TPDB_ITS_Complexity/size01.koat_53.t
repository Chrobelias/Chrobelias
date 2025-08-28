size01.koat_53
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_53.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it289 (* (- 2) it13) (* (- 1) i2)) 1)
                      (= (+ it290 (* (- 1) i3) (* 2 it13)) 0)
                      (= (+ it291 (* (- 1) i4 (exp (- 1) it13))) 0)
                      (= (+ it292 (* (- 1) i5 (exp (- 1) it13))) 0)
                      (= (+ it331 (* (- 1) it293) (* (- 1) (exp it290 2))
                         (* (- 1) (exp (+ (- 1) it290) 2))) 0)
                      (= (+ (* (- 8) (exp it13 3)) (* (- 6) i3 it13)
                         (* (- 6) it13 (exp i3 2)) (* (- 3) i6) (* (- 1) it13)
                         (* 3 it293) (* 6 (exp it13 2)) (* 12 i3 (exp it13 2))) 0)
                      (= (+ (* 2 it294) (* 2 it48)) 0)
                      (<= 1 it290)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it290) (* 2 it294)) (- 2))
                      (<= (+ (* (- 1) it290) (* 2 it294)) (- 1))
                      (<= (+ (* (- 1) it290) (* 2 it294) (* 2 it48)) (- 2))
                      (<= (+ (* (- 1) it290) (* 2 it294) (* 2 it48)) (- 1))
                      (<= (+ (* 2 it294) (* 2 it48)) 0)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it290) (- 2))
                      (<= (* (- 1) it294) (- 1))
                      (<= (* (- 1) it48) (- 1)))
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
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it290 2)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) it290) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
