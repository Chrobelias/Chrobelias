size01.koat_58
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_58.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it289 (* (- 2) it13) (* (- 1) i2)) 1)
                      (= (+ it290 (* (- 1) i3) (* 2 it13)) 0)
                      (= (+ it291 (* (- 1) i4 (exp (- 1) it13))) 0)
                      (= (+ it292 (* (- 1) i5 (exp (- 1) it13))) 0)
                      (= (+ it345 (* (- 2) it48) (* (- 1) it289)) 0)
                      (= (+ it346 (* (- 1) it290) (* 2 it48)) 0)
                      (= (+ it347 (* (- 1) it291 (exp (- 1) it48))) 0)
                      (= (+ it348 (* (- 1) it292 (exp (- 1) it48))) 0)
                      (= (+ (* (- 8) (exp it13 3)) (* (- 6) i3 it13)
                         (* (- 6) it13 (exp i3 2)) (* (- 3) i6) (* (- 1) it13)
                         (* 3 it293) (* 6 (exp it13 2)) (* 12 i3 (exp it13 2))) 0)
                      (= (+ (* (- 8) (exp it48 3)) (* (- 6) it290 it48)
                         (* (- 6) it48 (exp it290 2)) (* (- 3) it293)
                         (* (- 1) it48) (* 3 it349) (* 6 (exp it48 2))
                         (* 12 it290 (exp it48 2))) 0)
                      (= (+ (* 2 it294) (* 2 it350)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it290) (* 2 it48)) 0)
                      (<= (+ (* (- 1) it290) (* 2 it48)) 1)
                      (<= (+ (* (- 1) it346) (* 2 it294)) 0)
                      (<= (+ (* (- 1) it346) (* 2 it294)) 1)
                      (<= (+ (* (- 1) it346) (* 2 it294) (* 2 it350)) 0)
                      (<= (+ (* (- 1) it346) (* 2 it294) (* 2 it350)) 1)
                      (<= (+ (* 2 it294) (* 2 it350)) 0)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it294) (- 1))
                      (<= (* (- 1) it350) (- 1))
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
    0) it290
    1) it48
    
  Non linear arithmetic between
    0) it290
    1) (exp it48 2)
    
  Non linear arithmetic between
    0) it291
    1) (exp (- 1) it48)
    
  Non linear arithmetic between
    0) it292
    1) (exp (- 1) it48)
    
  Non linear arithmetic between
    0) it48
    1) (exp it290 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it290 2)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
