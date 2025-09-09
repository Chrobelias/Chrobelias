chc-LIA-Lin_300.smt2_24
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin/chc-LIA-Lin_300.smt2_24.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp it172 2)
    
  Leftover formula:
  (and
                      (= (+ it152 (* (- 1) (exp 5 it148))) 0)
                      (= (+ it155 (* (- 1) (exp 5 it148))) 0)
                      (= (+ it172 (* (- 2) it152) (* (- 1) (exp it172 2))
                         (* 2 it176)) 0)
                      (= (+ it172 (* (- 2) it155) (* (- 2) it172)
                         (* (- 1) (exp it172 2)) (* 2 it179)) 0)
                      (<= (+ it148 (* (- 1) it74)) 0)
                      (<= (+ it172 (* (- 1) it74)) 0)
                      (<= (+ it172 (* (- 1) it74)) 1)
                      (<= (+ it74 (* (- 1) it148)) 0)
                      (<= (* (- 1) it148) (- 1))
                      (<= (* (- 1) it172) (- 1)))
  Non linear arithmetic between
    0) (exp it172 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
