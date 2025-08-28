NonPeriodicNonterm2.jar-obl-8.smt2_5
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/NonPeriodicNonterm2.jar-obl-8.smt2_5.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it27))
                      (<= it4 0)
                      (<= 0 (* 2 it4))
                      (<= (+ it4 (* (- 2) it4)) 0)
                      (<= (+ (* (- 1) it27) (* (- 1) it4)
                          (* 2 it4 (exp 2 eee1)) (exp 2 eee1) (exp 2 eee1)) 1)
                      (<= (* (- 4) it4) 2)
                      (<= (* (- 2) it4) 1)
                      (<= (* (- 1) it27) (- 1))
                      (<= (* (- 1) it4) 0)
                      (<= (* (- 1) it4) 1))
  Non linear arithmetic between
    0) it4
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
