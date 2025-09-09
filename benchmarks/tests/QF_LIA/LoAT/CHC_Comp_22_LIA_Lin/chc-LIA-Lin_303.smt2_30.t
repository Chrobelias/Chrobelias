chc-LIA-Lin_303.smt2_30
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin/chc-LIA-Lin_303.smt2_30.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it215
    1) it324
    
  Non linear arithmetic between
    0) (exp it215 2)
    
  Non linear arithmetic between
    0) (exp it324 2)
    
  Non linear arithmetic between
    0) it215
    1) it324
    
  Non linear arithmetic between
    0) (exp it215 2)
    
  Non linear arithmetic between
    0) (exp it324 2)
    
  Leftover formula:
  (and
                      (= (+ it215 (* (- 2) it215 it324) (* (- 2) it328)
                         (* (- 1) (exp it215 2)) (* 2 it343)) 0)
                      (= (+ it324 (* (- 2) it324) (* (- 1) (exp it324 2))
                         (* 2 it331)) 2)
                      (= (+ it324 (* (- 1) (exp it324 2)) (* 2 it328)) 2)
                      (= (+ it341 (* (- 1) it215) (* (- 1) it324)) 0)
                      (= (+ it366 (* (- 1) it343 (exp 2 it362))) 0)
                      (= (+ it369 (* (- 1) it331 (exp 2 it362))) 0)
                      (<= 0 it132)
                      (<= (+ it132 (* (- 1) it301)) 0)
                      (<= (+ it132 (* (- 1) it324)) 0)
                      (<= (+ it132 (* (- 1) it341)) (- 1))
                      (<= (+ it132 (* (- 1) it362)) 0)
                      (<= (+ it215 it324 (* (- 1) it132)) 1)
                      (<= (+ it301 (* (- 1) it132)) 0)
                      (<= (+ it324 (* (- 1) it132)) 0)
                      (<= (+ it324 (* (- 1) it132)) 1)
                      (<= (+ it362 (* (- 1) it132)) 0)
                      (<= (* (- 1) it132) (- 1))
                      (<= (* (- 1) it215) (- 1))
                      (<= (* (- 1) it301) (- 1))
                      (<= (* (- 1) it324) (- 1))
                      (<= (* (- 1) it362) (- 1)))
  Non linear arithmetic between
    0) it215
    1) it324
    
  Non linear arithmetic between
    0) it331
    1) (exp 2 it362)
    
  Non linear arithmetic between
    0) it343
    1) (exp 2 it362)
    
  Non linear arithmetic between
    0) (exp it215 2)
    
  Non linear arithmetic between
    0) (exp it324 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
