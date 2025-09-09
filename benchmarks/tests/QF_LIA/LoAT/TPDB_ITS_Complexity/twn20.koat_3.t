twn20.koat_3
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn20.koat_3.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i4
    1) (exp 9 eee3)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp 4 eee4)
    
  Non linear arithmetic between
    0) (exp i5 3)
    
  Non linear arithmetic between
    0) (exp i5 3)
    1) (exp 9 eee3)
    
  Non linear arithmetic between
    0) (exp i5 5)
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 2) (* 2 it11)))
                      (= eee1 (+ (- 1) it11))
                      (<= 1 i3)
                      (<= 1 i5)
                      (<= (+ (* (- 1) i4) (exp i3 2) (exp i5 5)) (- 1))
                      (<= (+ (* (- 1) i4 (exp 9 eee1)) (* (- 1) (exp i5 3))
                          (* (exp i3 2) (exp 4 eee2))
                          (* (exp i5 3) (exp 9 eee1)) (exp i5 5)) (- 1))
                      (<= (* (- 1) it11) (- 1)))
  Non linear arithmetic between
    0) i4
    1) (exp 9 eee1)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp 4 eee2)
    
  Non linear arithmetic between
    0) (exp i5 3)
    
  Non linear arithmetic between
    0) (exp i5 3)
    1) (exp 9 eee1)
    
  Non linear arithmetic between
    0) (exp i5 5)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
