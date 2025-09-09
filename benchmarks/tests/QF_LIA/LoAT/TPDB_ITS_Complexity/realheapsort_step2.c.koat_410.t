realheapsort_step2.c.koat_410
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.c.koat_410.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (<= i4 (- 3))
                      (<= (+ i4 (* (- 2) i4)) 3)
                      (<= (+ i4 (* (- 1) i4 (exp 2 it101))
                          (* (- 1) (exp 2 it101))) 1)
                      (<= (+ (* i4 (exp 2 it101)) (* (- 1) i4) (exp 2 it101)) (- 1))
                      (<= (* (- 1) i4) (- 4))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it101) (- 1)))
  Non linear arithmetic between
    0) i4
    1) (exp 2 it101)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
