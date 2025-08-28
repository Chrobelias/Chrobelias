loop39.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/loop39.koat_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it11))
                      (<= (+ i3 (* (- 1) i4)) 1)
                      (<= (+ (* i3 (exp 2 eee1)) (* (- 1) i5)) 1)
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) it11) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
