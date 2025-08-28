Duplicate.jar-obl-8.smt2_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/Duplicate.jar-obl-8.smt2_1.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it17))
                      (= (+ it20 (* (- 1) it17) (* (- 1) it4)) 0)
                      (= (+ it21 (* (- 1) it3 (exp 2 it17))) 0)
                      (<= it21 0)
                      (<= (+ it21 (* (- 1) it20)) (- 1))
                      (<= (+ it3 (* (- 1) it4)) (- 1))
                      (<= (+ (* it3 (exp 2 eee1)) (* (- 1) it17) (* (- 1) it4)) (- 2))
                      (<= (* (- 1) it17) (- 1))
                      (<= (* (- 1) it21) (- 3))
                      (<= (* (- 1) it3) (- 3))
                      (<= (* (- 1) it3) 0)
                      (<= (* (- 1) it4) 0))
  Non linear arithmetic between
    0) it3
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) it3
    1) (exp 2 it17)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
