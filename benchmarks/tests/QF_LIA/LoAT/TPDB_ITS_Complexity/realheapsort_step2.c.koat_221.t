realheapsort_step2.c.koat_221
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.c.koat_221.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it1094 (* (- 11) i4) (* (- 1) i2)) (- 17))
                      (<= (+ i4 i4) (- 1))
                      (<= (+ i4 i4) 0)
                      (<= (+ i4 (* i4 (exp 2 it316)) (* (- 1) i4)
                          (* 2 (exp 2 it316))) 3)
                      (<= (+ i4 (* i4 (exp 2 it316)) (* (- 1) i4)
                          (* 2 (exp 2 it316))) 4)
                      (<= (* (- 1) i4) (- 4))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) i4) 2)
                      (<= (* (- 1) it316) (- 1)))
  Non linear arithmetic between
    0) i4
    1) (exp 2 it316)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
