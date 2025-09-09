twn03.koat_3
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn03.koat_3.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it27
    1) (exp 5 eee3)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) it27
    1) (exp 5 eee6)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee5)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) it27
    1) (exp 5 eee9)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee8)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Leftover formula:
  (and
                      (= eee1 (+ (- 2) (* 2 it16)))
                      (= (+ it26 (* (- 1) i2) (* (- 1) i5)) 1)
                      (= (+ (* (- 2) i3) (* (- 1) i5) (* (- 1) (exp i5 2))
                         (* 2 it27)) 0)
                      (<= 1 i3)
                      (<= (+ it27 (* (- 1) (exp i4 2))) (- 1))
                      (<= (+ (* (- 16) (exp i4 2) (exp 2 eee1))
                          (* 4 it27 (exp 5 it16))) (- 1))
                      (<= (* (- 1) i5) (- 1))
                      (<= (* (- 1) it16) (- 1)))
  Non linear arithmetic between
    0) it27
    1) (exp 5 it16)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
