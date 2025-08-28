NonPeriodicNonterm2.jar-obl-8.smt2_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/NonPeriodicNonterm2.jar-obl-8.smt2_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it27))
                      (= (+ it19 it21 (* (- 1) it4)) 0)
                      (<= 0 (* 2 it21))
                      (<= (+ it19 it3 (* (- 1) it4)) 0)
                      (<= (+ it19 (* (- 1) it4)) 1)
                      (<= (+ it21 (* (- 1) it3)) 0)
                      (<= (+ it3 (* (- 1) it21)) 0)
                      (<= (+ it3 (* (- 1) it4)) 0)
                      (<= (+ (* it21 (exp 2 eee1)) (* (- 1) it27) (* (- 1) it3)
                          (exp 2 eee1)) 0)
                      (<= (* (- 1) it19) (- 1))
                      (<= (* (- 1) it21) 0)
                      (<= (* (- 1) it27) (- 1))
                      (<= (* (- 1) it3) 0)
                      (<= (* (- 1) it4) 0))
  Non linear arithmetic between
    0) it21
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
