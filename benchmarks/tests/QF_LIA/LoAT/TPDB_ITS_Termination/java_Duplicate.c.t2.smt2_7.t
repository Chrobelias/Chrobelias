java_Duplicate.c.t2.smt2_7
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/java_Duplicate.c.t2.smt2_7.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it38
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) it38
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) it38
    1) (exp 2 eee4)
    
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it115))
                      (<= (+ it38 (* (- 1) it37)) (- 1))
                      (<= (+ (* it38 (exp 2 eee1)) (* (- 1) it115)
                          (* (- 1) it37)) (- 2))
                      (<= (* (- 1) it115) (- 1))
                      (<= (* (- 1) it38) (- 3)))
  Non linear arithmetic between
    0) it38
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
