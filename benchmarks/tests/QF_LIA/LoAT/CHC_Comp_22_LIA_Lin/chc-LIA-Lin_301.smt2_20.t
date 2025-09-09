chc-LIA-Lin_301.smt2_20
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin/chc-LIA-Lin_301.smt2_20.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it142
    1) it158
    
  Non linear arithmetic between
    0) (exp it142 2)
    
  Non linear arithmetic between
    0) (exp it158 2)
    
  Leftover formula:
  (and
                      (= (+ it122 (* (- 1) (exp 5 it118))) 0)
                      (= (+ it125 (* (- 1) (exp 5 it118))) 0)
                      (= (+ it142 (* (- 2) it122) (* (- 1) (exp it142 2))
                         (* 2 it146)) 0)
                      (= (+ it142 (* (- 2) it125) (* (- 2) it142)
                         (* (- 1) (exp it142 2)) (* 2 it149)) 0)
                      (= (+ it158 (* (- 2) it142 it158) (* (- 2) it146)
                         (* (- 1) (exp it158 2)) (* 2 it162)) 0)
                      (= (+ it160 (* (- 1) it142) (* (- 1) it158)) 0)
                      (<= (+ it118 (* (- 1) it77)) 0)
                      (<= (+ it142 it158 (* (- 1) it77)) 1)
                      (<= (+ it142 (* (- 1) it77)) 0)
                      (<= (+ it142 (* (- 1) it77)) 1)
                      (<= (+ it77 (* (- 1) it118)) 0)
                      (<= (+ it77 (* (- 1) it142)) 0)
                      (<= (+ it77 (* (- 1) it160)) (- 1))
                      (<= (* (- 1) it118) (- 1))
                      (<= (* (- 1) it142) (- 1))
                      (<= (* (- 1) it158) (- 1))
                      ((<= (+ it162 (* (- 1) it149)) (- 1)) | (<= (+ it149
                                                                  (* (- 1)
                                                                  it162)) (- 1))))
  Non linear arithmetic between
    0) it142
    1) it158
    
  Non linear arithmetic between
    0) (exp it142 2)
    
  Non linear arithmetic between
    0) (exp it158 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
