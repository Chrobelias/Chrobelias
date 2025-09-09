chc-LIA-Lin_304.smt2_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin/chc-LIA-Lin_304.smt2_0.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it176
    1) it229
    
  Non linear arithmetic between
    0) (exp it176 2)
    
  Non linear arithmetic between
    0) (exp it229 2)
    
  Non linear arithmetic between
    0) it176
    1) it229
    
  Non linear arithmetic between
    0) (exp it176 2)
    
  Non linear arithmetic between
    0) (exp it229 2)
    
  Leftover formula:
  (and
                      (= (+ it176 (* (- 2) it176 it229) (* (- 2) it233)
                         (* (- 1) (exp it176 2)) (* 2 it248)) 0)
                      (= (+ it229 (* (- 2) it229) (* (- 1) (exp it229 2))
                         (* 2 it236)) 2)
                      (= (+ it229 (* (- 1) (exp it229 2)) (* 2 it233)) 2)
                      (= (+ it246 (* (- 1) it176) (* (- 1) it229)) 0)
                      (= (+ it271 (* (- 1) it248 (exp 2 it267))) 0)
                      (= (+ it274 (* (- 1) it236 (exp 2 it267))) 0)
                      (<= (+ it108 (* (- 1) it206)) 0)
                      (<= (+ it108 (* (- 1) it229)) 0)
                      (<= (+ it108 (* (- 1) it246)) (- 1))
                      (<= (+ it108 (* (- 1) it267)) 0)
                      (<= (+ it176 it229 (* (- 1) it108)) 1)
                      (<= (+ it206 (* (- 1) it108)) 0)
                      (<= (+ it229 (* (- 1) it108)) 0)
                      (<= (+ it229 (* (- 1) it108)) 1)
                      (<= (+ it267 (* (- 1) it108)) 0)
                      (<= (* (- 1) it176) (- 1))
                      (<= (* (- 1) it206) (- 1))
                      (<= (* (- 1) it229) (- 1))
                      (<= (* (- 1) it267) (- 1))
                      ((<= (+ it271 (* (- 1) it274)) (- 1)) | (<= (+ it274
                                                                  (* (- 1)
                                                                  it271)) (- 1))))
  Non linear arithmetic between
    0) it176
    1) it229
    
  Non linear arithmetic between
    0) it236
    1) (exp 2 it267)
    
  Non linear arithmetic between
    0) it248
    1) (exp 2 it267)
    
  Non linear arithmetic between
    0) (exp it176 2)
    
  Non linear arithmetic between
    0) (exp it229 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
