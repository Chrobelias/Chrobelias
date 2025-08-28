java_Duplicate.c.t2.smt2_33
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/java_Duplicate.c.t2.smt2_33.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it115))
                      (= (+ it301 (* (- 1) it38 (exp 2 eee1))) 0)
                      (= (+ it302 (* (- 1) it115) (* (- 1) it37)) (- 1))
                      (= (+ it305 (* (- 1) it38 (exp 2 it115))) 0)
                      (= (+ it306 (* (- 1) it115) (* (- 1) it37)) 0)
                      (<= it305 0)
                      (<= (+ it305 (* (- 1) it306)) (- 1))
                      (<= (+ it38 (* (- 1) it37)) (- 1))
                      (<= (+ (* it38 (exp 2 eee1)) (* (- 1) it115)
                          (* (- 1) it37)) (- 2))
                      (<= (* (- 1) it115) (- 1))
                      (<= (* (- 1) it305) (- 3))
                      (<= (* (- 1) it38) (- 3)))
  Non linear arithmetic between
    0) it38
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) it38
    1) (exp 2 it115)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
