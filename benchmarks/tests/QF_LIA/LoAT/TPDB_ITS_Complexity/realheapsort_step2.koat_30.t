realheapsort_step2.koat_30
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_30.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ 1 it273))
                      (= (+ it277 (* (- 6) it273) (* (- 1) i2)) 5)
                      (= (+ it280 (* (- 1) (exp 2 eee1))) (- 2))
                      (= (+ it281 (* (- 2) (exp 2 it273))) (- 2))
                      (<= (+ (* (- 2) it280) (* 2 it280 (exp 2 it87))
                          (exp 2 it87) (exp 2 it87)) 2)
                      (<= (+ (* (- 2) it280) (* 2 (exp 2 it273))) 3)
                      (<= (+ (* (- 2) it280) (* 2 (exp 2 it273))) 4)
                      (<= (+ (* (- 2) it280 (exp 2 it87))
                          (* (- 2) (exp 2 it87)) (* 2 it280)) (- 2))
                      (<= (* (- 2) it280) 0)
                      (<= (* (- 2) it280) 1)
                      (<= (* (- 2) it280) 2)
                      (<= (* (- 1) it273) (- 1))
                      (<= (* (- 1) it280) (- 1))
                      (<= (* (- 1) it87) (- 1))
                      (<= (* 2 it280) (- 2)))
  Non linear arithmetic between
    0) it280
    1) (exp 2 it87)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
