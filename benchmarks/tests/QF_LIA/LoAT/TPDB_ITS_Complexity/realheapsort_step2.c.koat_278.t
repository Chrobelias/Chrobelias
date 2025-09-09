realheapsort_step2.c.koat_278
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.c.koat_278.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it1318 (* (- 11) i4) (* (- 1) i2)) (- 17))
                      (<= (+ i4 i4) 0)
                      (<= (+ i4 (* i4 (exp 2 it101)) (* (- 1) i4)
                          (exp 2 it101)) 2)
                      (<= (+ i4 (* (- 3) i4)) 0)
                      (<= (+ (* (- 1) i4 (exp 2 it101))
                          (* (- 1) (exp 2 it101))) (- 2))
                      (<= (* (- 1) i4) (- 4))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) i4) 2)
                      (<= (* (- 1) it101) (- 1)))
  Non linear arithmetic between
    0) i4
    1) (exp 2 it101)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
