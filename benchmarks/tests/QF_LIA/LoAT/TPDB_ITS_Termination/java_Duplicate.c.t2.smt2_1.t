java_Duplicate.c.t2.smt2_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/java_Duplicate.c.t2.smt2_1.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it115))
                      (= (+ it118 (* (- 2) i7 (exp 2 eee1))) 0)
                      (= (+ it119 (* (- 1) i8) (* (- 1) it115)) 0)
                      (= (+ it122 (* (- 2) i7 (exp 2 it115))) 0)
                      (= (+ it123 (* (- 1) i8) (* (- 1) it115)) 1)
                      (<= it122 0)
                      (<= (+ it122 (* (- 1) it123)) (- 1))
                      (<= (+ (* (- 1) i8) (* (- 1) it115)
                          (* 2 i7 (exp 2 eee1))) (- 1))
                      (<= (+ (* (- 1) i8) (* 2 i7)) 0)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it115) (- 1))
                      (<= (* (- 1) it122) (- 3)))
  Non linear arithmetic between
    0) i7
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) i7
    1) (exp 2 it115)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
