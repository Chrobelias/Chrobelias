size01.koat_14
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_14.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (* it13 it73) (* it48 it73)))
                      (= (+ it77 (* (- 2) it13 it73) (* (- 2) it48 it73)
                         (* (- 1) i2)) 1)
                      (= (+ it78 (* (- 1) i3) (* 2 it13 it73) (* 2 it48 it73)) 0)
                      (= (+ it79 (* (- 1) i4 (exp (- 1) eee1))) 0)
                      (= (+ it80 (* (- 1) i5 (exp (- 1) eee1))) 0)
                      (= (+ (* (- 24) it13 (exp it48 2) (exp it73 3))
                         (* (- 24) it48 (exp it13 2) (exp it73 3))
                         (* (- 8) (exp it13 3) (exp it73 3))
                         (* (- 8) (exp it48 3) (exp it73 3))
                         (* (- 6) i3 it13 it73) (* (- 6) i3 it48 it73)
                         (* (- 6) it13 it73 (exp i3 2))
                         (* (- 6) it48 it73 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it13 it73) (* (- 1) it48 it73) (* 3 it81)
                         (* 6 (exp it13 2) (exp it73 2))
                         (* 6 (exp it48 2) (exp it73 2))
                         (* 12 i3 (exp it13 2) (exp it73 2))
                         (* 12 i3 (exp it48 2) (exp it73 2))
                         (* 12 it13 it48 (exp it73 2))
                         (* 24 i3 it13 it48 (exp it73 2))) 0)
                      (<= 1 it78)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it73) (* 2 it48)
                          (* 2 it48 it73)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it73) (* 2 it48)
                          (* 2 it48 it73)) 1)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it73) (* 2 it48 it73)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it73) (* 2 it48 it73)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it13) (* 2 it48)) 0)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it48) (- 1))
                      (<= (* (- 1) it73) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it13
    2) it48
    3) (exp it73 2)
    
  Non linear arithmetic between
    0) i3
    1) it13
    2) it73
    
  Non linear arithmetic between
    0) i3
    1) it48
    2) it73
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it48 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it13
    1) it48
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it13
    1) it73
    
  Non linear arithmetic between
    0) it13
    1) it73
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it48 2)
    2) (exp it73 3)
    
  Non linear arithmetic between
    0) it48
    1) it73
    
  Non linear arithmetic between
    0) it48
    1) it73
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it48
    1) (exp it13 2)
    2) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    1) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it13 3)
    1) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 2)
    1) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp it48 3)
    1) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it73 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
