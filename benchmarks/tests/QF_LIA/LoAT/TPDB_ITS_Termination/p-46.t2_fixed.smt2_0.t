p-46.t2_fixed.smt2_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/p-46.t2_fixed.smt2_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it139))
                      (<= (+ i3 (* (- 2) it19)) (- 1))
                      (<= (+ (* (- 4) it19) (* 2 i3 (exp 3 eee1)) (exp 3 eee1)) (- 1))
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) it139) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 3 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
