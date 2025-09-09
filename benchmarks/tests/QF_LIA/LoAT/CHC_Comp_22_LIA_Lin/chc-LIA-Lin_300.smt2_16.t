chc-LIA-Lin_300.smt2_16
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin/chc-LIA-Lin_300.smt2_16.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it125
    1) it172
    
  Non linear arithmetic between
    0) (exp it125 2)
    
  Non linear arithmetic between
    0) (exp it172 2)
    
  Leftover formula:
  (and
                      (= (+ it125 (* (- 2) it125 it172) (* (- 2) it176)
                         (* (- 1) (exp it125 2)) (* 2 it184)) 0)
                      (= (+ it152 (* (- 1) (exp 5 it148))) 0)
                      (= (+ it155 (* (- 1) (exp 5 it148))) 0)
                      (= (+ it172 (* (- 2) it152) (* (- 1) (exp it172 2))
                         (* 2 it176)) 0)
                      (= (+ it172 (* (- 2) it155) (* (- 2) it172)
                         (* (- 1) (exp it172 2)) (* 2 it179)) 0)
                      (= (+ it182 (* (- 1) it125) (* (- 1) it172)) 0)
                      (<= (+ it125 it172 (* (- 1) it74)) 1)
                      (<= (+ it148 (* (- 1) it74)) 0)
                      (<= (+ it172 (* (- 1) it74)) 0)
                      (<= (+ it172 (* (- 1) it74)) 1)
                      (<= (+ it74 (* (- 1) it148)) 0)
                      (<= (+ it74 (* (- 1) it172)) 0)
                      (<= (+ it74 (* (- 1) it182)) (- 1))
                      (<= (* (- 1) it125) (- 1))
                      (<= (* (- 1) it148) (- 1))
                      (<= (* (- 1) it172) (- 1))
                      ((<= (+ it184 (* (- 1) it179)) (- 1)) | (<= (+ it179
                                                                  (* (- 1)
                                                                  it184)) (- 1))))
  Non linear arithmetic between
    0) it125
    1) it172
    
  Non linear arithmetic between
    0) (exp it125 2)
    
  Non linear arithmetic between
    0) (exp it172 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
