twn02.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn02.koat_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it11))
                      (= eee1 (+ (- 2) (* 2 it11)))
                      (<= 1 i3)
                      (<= (+ (* (- 4) (exp i4 2) (exp 2 eee1))
                          (* (- 1) (exp i5 2)) (* 4 i3 (exp 5 eee2))
                          (* (exp i5 2) (exp 5 eee2))) (- 1))
                      (<= (* (- 1) it11) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i5 2)
    1) (exp 5 eee2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
