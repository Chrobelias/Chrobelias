twn08.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn08.koat_0.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i5
    1) (exp 5 eee4)
    
  Non linear arithmetic between
    0) (exp i6 2)
    
  Non linear arithmetic between
    0) (exp i6 2)
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) (exp i7 2)
    
  Non linear arithmetic between
    0) (exp i7 2)
    1) (exp 5 eee4)
    
  Non linear arithmetic between
    0) i5
    1) (exp 5 eee6)
    
  Non linear arithmetic between
    0) (exp i6 2)
    
  Non linear arithmetic between
    0) (exp i6 2)
    1) (exp 2 eee5)
    
  Non linear arithmetic between
    0) (exp i7 2)
    
  Non linear arithmetic between
    0) (exp i7 2)
    1) (exp 5 eee6)
    
  Non linear arithmetic between
    0) i5
    1) (exp 5 eee8)
    
  Non linear arithmetic between
    0) (exp i6 2)
    
  Non linear arithmetic between
    0) (exp i6 2)
    1) (exp 2 eee7)
    
  Non linear arithmetic between
    0) (exp i7 2)
    
  Non linear arithmetic between
    0) (exp i7 2)
    1) (exp 5 eee8)
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it256))
                      (= eee1 (+ (- 2) (* 2 it256)))
                      (= (+ it2 it23 (* (- 1) i2)) 5)
                      (<= it2 3)
                      (<= 1 i4)
                      (<= 1 i5)
                      (<= (+ (* (- 4) (exp i6 2) (exp 2 eee1))
                          (* (- 1) (exp i7 2)) (* 4 i5 (exp 5 eee2))
                          (* (exp i7 2) (exp 5 eee2))) (- 1))
                      (<= (* (- 1) it2) (- 1))
                      (<= (* (- 1) it256) (- 1)))
  Non linear arithmetic between
    0) i5
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i6 2)
    
  Non linear arithmetic between
    0) (exp i6 2)
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) (exp i7 2)
    
  Non linear arithmetic between
    0) (exp i7 2)
    1) (exp 5 eee2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
