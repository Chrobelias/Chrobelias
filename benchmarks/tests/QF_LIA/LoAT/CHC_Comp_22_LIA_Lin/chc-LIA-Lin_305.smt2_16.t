chc-LIA-Lin_305.smt2_16
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin/chc-LIA-Lin_305.smt2_16.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it135
    1) it390
    
  Non linear arithmetic between
    0) it215
    1) it324
    
  Non linear arithmetic between
    0) (exp it215 2)
    
  Non linear arithmetic between
    0) (exp it324 2)
    
  Non linear arithmetic between
    0) (exp it390 2)
    
  Non linear arithmetic between
    0) it135
    1) it390
    
  Non linear arithmetic between
    0) it215
    1) it324
    
  Non linear arithmetic between
    0) (exp it215 2)
    
  Non linear arithmetic between
    0) (exp it324 2)
    
  Non linear arithmetic between
    0) (exp it390 2)
    
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
                      (= (+ it390 it394 (* (- 1) it135)) 0)
                      (= (+ it390 it396 (* (- 1) it135)) 0)
                      (= (+ (* (- 2) it135 it390) (* (- 2) it366)
                         (* (- 1) it390) (* 2 it395) (exp it390 2)) 0)
                      (= (+ (* (- 2) it135 it390) (* (- 2) it369)
                         (* (- 1) it390) (* 2 it397) (exp it390 2)) 0)
                      (<= 0 it135)
                      (<= 0 it394)
                      (<= 0 (* (- 1) it396))
                      (<= 1 it135)
                      (<= (+ it135 (* (- 1) it301)) 0)
                      (<= (+ it135 (* (- 1) it324)) 0)
                      (<= (+ it135 (* (- 1) it341)) (- 1))
                      (<= (+ it135 (* (- 1) it362)) 0)
                      (<= (+ it215 it324 (* (- 1) it135)) 1)
                      (<= (+ it249 (* (- 1) it394)) 1)
                      (<= (+ it301 (* (- 1) it135)) 0)
                      (<= (+ it324 (* (- 1) it135)) 0)
                      (<= (+ it324 (* (- 1) it135)) 1)
                      (<= (+ it362 (* (- 1) it135)) 0)
                      (<= (+ it390 (* (- 1) it135)) 0)
                      (<= (+ it390 (* (- 1) it135)) 1)
                      (<= (* (- 1) it215) (- 1))
                      (<= (* (- 1) it249) (- 1))
                      (<= (* (- 1) it301) (- 1))
                      (<= (* (- 1) it324) (- 1))
                      (<= (* (- 1) it362) (- 1))
                      (<= (* (- 1) it390) (- 1)))
  Non linear arithmetic between
    0) it135
    1) it390
    
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
    
  Non linear arithmetic between
    0) (exp it390 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
