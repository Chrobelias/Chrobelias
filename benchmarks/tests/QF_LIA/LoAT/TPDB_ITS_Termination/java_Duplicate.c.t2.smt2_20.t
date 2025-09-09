java_Duplicate.c.t2.smt2_20
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/java_Duplicate.c.t2.smt2_20.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i7
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) i7
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) i7
    1) (exp 2 eee4)
    
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it115))
                      (<= (+ i7 (* (- 1) i8)) (- 1))
                      (<= (+ (* i7 (exp 2 eee1)) (* (- 1) i8) (* (- 1) it115)) (- 2))
                      (<= (* (- 1) i7) (- 3))
                      (<= (* (- 1) it115) (- 1)))
  Non linear arithmetic between
    0) i7
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
