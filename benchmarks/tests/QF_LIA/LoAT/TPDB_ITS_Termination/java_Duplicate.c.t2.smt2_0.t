java_Duplicate.c.t2.smt2_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/java_Duplicate.c.t2.smt2_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it115))
                      (<= (+ (* (- 1) i8) (* (- 1) it115)
                          (* 2 i7 (exp 2 eee1))) (- 1))
                      (<= (+ (* (- 1) i8) (* 2 i7)) 0)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it115) (- 1)))
  Non linear arithmetic between
    0) i7
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
