Duplicate.jar-obl-8.smt2_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/Duplicate.jar-obl-8.smt2_0.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it3
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) it3
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) it3
    1) (exp 2 eee4)
    
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it17))
                      (<= (+ it3 (* (- 1) it4)) (- 1))
                      (<= (+ (* it3 (exp 2 eee1)) (* (- 1) it17) (* (- 1) it4)) (- 2))
                      (<= (* (- 1) it17) (- 1))
                      (<= (* (- 1) it3) (- 3))
                      (<= (* (- 1) it3) 0)
                      (<= (* (- 1) it4) 0))
  Non linear arithmetic between
    0) it3
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
