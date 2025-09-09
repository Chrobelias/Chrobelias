realheapsort_step2.koat_131
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_131.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ 1 it420))
                      (= eee1 (+ 1 it273))
                      (= (+ it415 (* (- 6) it273) (* (- 1) i2)) 5)
                      (= (+ it418 (* (- 1) (exp 2 eee1))) (- 2))
                      (= (+ it419 (* (- 2) (exp 2 it273))) (- 2))
                      (= (+ it480 (* (- 6) it420) (* (- 1) it415)) 8)
                      (= (+ it483 (* (- 1) (exp 2 eee2))) (- 2))
                      (= (+ it484 (* (- 2) (exp 2 it420))) (- 2))
                      (<= (+ (* it483 (exp 2 it87)) (* (- 2) it418)
                          (exp 2 it87)) 1)
                      (<= (+ (* (- 2) it418) (* 2 it483)) (- 1))
                      (<= (+ (* (- 2) it418) (* 2 (exp 2 it273))) 3)
                      (<= (+ (* (- 2) it418) (* 2 (exp 2 it273))) 4)
                      (<= (+ (* (- 2) it418) (* 2 (exp 2 it420))) 2)
                      (<= (+ (* (- 2) it418) (* 2 (exp 2 it420))) 3)
                      (<= (+ (* (- 2) it483) (* 2 it418)) 1)
                      (<= (+ (* (- 1) it483 (exp 2 it87))
                          (* (- 1) (exp 2 it87)) (* 2 it418)) (- 1))
                      (<= (* (- 2) it418) 0)
                      (<= (* (- 2) it418) 1)
                      (<= (* (- 2) it418) 5)
                      (<= (* (- 1) it273) (- 1))
                      (<= (* (- 1) it418) (- 1))
                      (<= (* (- 1) it420) (- 1))
                      (<= (* (- 1) it87) (- 1)))
  Non linear arithmetic between
    0) it483
    1) (exp 2 it87)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
