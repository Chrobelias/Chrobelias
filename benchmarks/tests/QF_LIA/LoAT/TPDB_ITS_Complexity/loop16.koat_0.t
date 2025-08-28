loop16.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/loop16.koat_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it7))
                      (<= (+ (* i3 (exp 2 eee1)) (* 10 (exp 2 eee1))) 109)
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) it7) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
