java_Duplicate.c.t2.smt2_13
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/java_Duplicate.c.t2.smt2_13.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it115))
                      (= (+ it170 (* (- 1) it38 (exp 2 eee1))) 0)
                      (= (+ it171 (* (- 1) it115) (* (- 1) it37)) (- 1))
                      (= (+ it174 (* (- 1) it38 (exp 2 it115))) 0)
                      (= (+ it175 (* (- 1) it115) (* (- 1) it37)) 0)
                      (<= (+ it174 (* (- 1) it175)) (- 1))
                      (<= (+ it38 (* (- 1) it37)) (- 1))
                      (<= (+ (* it38 (exp 2 eee1)) (* (- 1) it115)
                          (* (- 1) it37)) (- 2))
                      (<= (+ (* (- 1) it175) (* 2 it174)) 0)
                      (<= (* (- 1) it115) (- 1))
                      (<= (* (- 1) it174) (- 3))
                      (<= (* (- 1) it174) (- 2))
                      (<= (* (- 1) it38) (- 3))
                      (<= (* 2 it174) 0))
  Non linear arithmetic between
    0) it38
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) it38
    1) (exp 2 it115)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
