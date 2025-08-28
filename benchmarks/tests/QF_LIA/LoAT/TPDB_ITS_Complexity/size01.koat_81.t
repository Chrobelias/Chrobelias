size01.koat_81
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_81.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (* it13 it436) (* it436 it48)))
                      (= (+ it440 (* (- 2) it13 it436) (* (- 2) it436 it48)
                         (* (- 1) i2)) 1)
                      (= (+ it441 (* (- 1) i3) (* 2 it13 it436)
                         (* 2 it436 it48)) 0)
                      (= (+ it442 (* (- 1) i4 (exp (- 1) eee1))) 0)
                      (= (+ it443 (* (- 1) i5 (exp (- 1) eee1))) 0)
                      (= (+ (* (- 24) it13 (exp it436 3) (exp it48 2))
                         (* (- 24) it48 (exp it13 2) (exp it436 3))
                         (* (- 8) (exp it13 3) (exp it436 3))
                         (* (- 8) (exp it436 3) (exp it48 3))
                         (* (- 6) i3 it13 it436) (* (- 6) i3 it436 it48)
                         (* (- 6) it13 it436 (exp i3 2))
                         (* (- 6) it436 it48 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it13 it436) (* (- 1) it436 it48) (* 3 it444)
                         (* 6 (exp it13 2) (exp it436 2))
                         (* 6 (exp it436 2) (exp it48 2))
                         (* 12 i3 (exp it13 2) (exp it436 2))
                         (* 12 i3 (exp it436 2) (exp it48 2))
                         (* 12 it13 it48 (exp it436 2))
                         (* 24 i3 it13 it48 (exp it436 2))) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it436) (* 2 it436 it48)
                          (* 2 it48)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it436) (* 2 it436 it48)
                          (* 2 it48)) 1)
                      (<= (+ (* (- 2) it13) (* (- 1) i3) (* 2 it13 it436)
                          (* 2 it436 it48)) 0)
                      (<= (+ (* (- 2) it13) (* (- 1) i3) (* 2 it13 it436)
                          (* 2 it436 it48)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it13) (* 2 it48)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it48)) 0)
                      (<= (+ (* (- 1) it441) (* 2 it446)) 0)
                      (<= (+ (* (- 1) it441) (* 2 it446)) 1)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it436) (- 1))
                      (<= (* (- 1) it446) (- 1))
                      (<= (* (- 1) it48) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it13
    2) it436
    
  Non linear arithmetic between
    0) i3
    1) it13
    2) it48
    3) (exp it436 2)
    
  Non linear arithmetic between
    0) i3
    1) it436
    2) it48
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    2) (exp it436 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it436 2)
    2) (exp it48 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it13
    1) it436
    
  Non linear arithmetic between
    0) it13
    1) it436
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it13
    1) it48
    2) (exp it436 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it436 3)
    2) (exp it48 2)
    
  Non linear arithmetic between
    0) it436
    1) it48
    
  Non linear arithmetic between
    0) it436
    1) it48
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it48
    1) (exp it13 2)
    2) (exp it436 3)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    1) (exp it436 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it13 3)
    1) (exp it436 3)
    
  Non linear arithmetic between
    0) (exp it436 2)
    
  Non linear arithmetic between
    0) (exp it436 2)
    1) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it436 3)
    
  Non linear arithmetic between
    0) (exp it436 3)
    1) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
