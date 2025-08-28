twn16.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn16.koat_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it7))
                      (<= 1 i3)
                      (<= (* i3 (exp 17 eee1)) 41)
                      (<= (* (- 1) it7) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 17 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
