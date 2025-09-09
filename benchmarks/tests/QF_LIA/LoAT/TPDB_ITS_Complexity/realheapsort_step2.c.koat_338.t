realheapsort_step2.c.koat_338
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.c.koat_338.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ 1 it316))
                      (= (+ it1556 (* (- 6) it316) (* (- 1) i2)) 18)
                      (= (+ it1559 (* (- 1) (exp 2 eee1))) (- 2))
                      (= (+ it1561 (* (- 2) (exp 2 it316))) (- 2))
                      (= (+ it1576 (* (- 11) i4) (* (- 1) it1556)) (- 40))
                      (<= (+ i4 i4) (- 1))
                      (<= (+ i4 i4) 0)
                      (<= (+ i4 (* i4 (exp 2 it1562)) (* (- 1) i4)
                          (* 2 (exp 2 it1562))) 3)
                      (<= (+ i4 (* i4 (exp 2 it1562)) (* (- 1) i4)
                          (* 2 (exp 2 it1562))) 4)
                      (<= (+ i4 (* (- 2) it1559)) 2)
                      (<= (+ (* (- 1) i4) (* 2 (exp 2 it316))) 0)
                      (<= (+ (* (- 1) i4) (* 2 (exp 2 it316))) 1)
                      (<= (* (- 1) i4) (- 5))
                      (<= (* (- 1) i4) (- 4))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) i4) 3)
                      (<= (* (- 1) it1562) (- 1))
                      (<= (* (- 1) it316) (- 1)))
  Non linear arithmetic between
    0) i4
    1) (exp 2 it1562)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
