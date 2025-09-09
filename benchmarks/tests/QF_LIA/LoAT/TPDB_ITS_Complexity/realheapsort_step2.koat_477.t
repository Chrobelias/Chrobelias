realheapsort_step2.koat_477
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_477.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it1018 (* (- 9) i3) (* (- 1) i2)) (- 26))
                      (<= (+ i3 i3) 0)
                      (<= (+ i3 i3) 1)
                      (<= (+ i3 (* i3 (exp 2 it273)) (* (- 1) i3)
                          (* 2 (exp 2 it273))) 4)
                      (<= (+ i3 (* i3 (exp 2 it273)) (* (- 1) i3)
                          (* 2 (exp 2 it273))) 5)
                      (<= (+ i3 (* (- 2) i3)) 2)
                      (<= (* (- 1) i3) (- 5))
                      (<= (* (- 1) i3) (- 4))
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) it273) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 it273)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
