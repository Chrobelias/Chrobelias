p-46.t2_fixed.smt2_8
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/p-46.t2_fixed.smt2_8.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it139))
                      (= (+ (* (- 2) i3 (exp 3 it139)) (* (- 1) (exp 3 it139))
                         (* 2 it144)) (- 1))
                      (= (+ (* (- 2) i3 (exp 3 eee1)) (* (- 1) (exp 3 eee1))
                         (* 2 it145)) (- 1))
                      (<= (+ i3 (* (- 2) it19)) (- 1))
                      (<= (+ (* (- 4) it19) (* 2 i3 (exp 3 eee1)) (exp 3 eee1)) (- 1))
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) it139) (- 1))
                      (<= (* (- 1) it144) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 3 eee1)
    
  Non linear arithmetic between
    0) i3
    1) (exp 3 it139)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
