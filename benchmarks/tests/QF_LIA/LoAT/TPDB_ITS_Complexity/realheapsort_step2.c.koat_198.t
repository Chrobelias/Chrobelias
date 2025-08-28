realheapsort_step2.c.koat_198
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.c.koat_198.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it316))
                      (= (* (- 1) i4) (- 3))
                      (<= i4 (- 4))
                      (<= i4 (- 3))
                      (<= (+ (* (- 1) i4) (* 2 i4 (exp 2 eee1))
                          (* 2 (exp 2 it316))) 0)
                      (<= (+ (* (- 1) i4) (* 2 i4 (exp 2 eee1))
                          (* 2 (exp 2 it316))) 1)
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it316) (- 1)))
  Non linear arithmetic between
    0) i4
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
