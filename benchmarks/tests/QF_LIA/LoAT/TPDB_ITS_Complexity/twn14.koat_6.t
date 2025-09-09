twn14.koat_6
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn14.koat_6.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i7
    1) (exp 9 eee3)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp 4 eee4)
    
  Non linear arithmetic between
    0) (exp i6 3)
    
  Non linear arithmetic between
    0) (exp i6 3)
    1) (exp 9 eee3)
    
  Non linear arithmetic between
    0) (exp i6 5)
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 2) (* 2 it109)))
                      (= eee1 (+ (- 1) it109))
                      (<= i6 5)
                      (<= 1 i3)
                      (<= 1 (* 2 i3))
                      (<= (+ (* (- 3) i7 (exp 9 eee1)) (* (- 1) (exp i6 3))
                          (* 3 (exp i6 3) (exp 9 eee1))
                          (* 4 (exp i3 2) (exp 4 eee2)) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) i7) (exp i3 2) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) i7 (exp 9 eee1)) (* (- 1) (exp i6 3))
                          (* (exp i3 2) (exp 4 eee2))
                          (* (exp i6 3) (exp 9 eee1)) (exp i6 5)) (- 1))
                      (<= (* (- 1) i6) 5)
                      (<= (* (- 1) it109) (- 1)))
  Non linear arithmetic between
    0) i7
    1) (exp 9 eee1)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp 4 eee2)
    
  Non linear arithmetic between
    0) (exp i6 3)
    
  Non linear arithmetic between
    0) (exp i6 3)
    1) (exp 9 eee1)
    
  Non linear arithmetic between
    0) (exp i6 5)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
