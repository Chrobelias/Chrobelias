realheapsort_step2.koat_487
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_487.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it273))
                      (= (+ it1018 (* (- 9) i3) (* (- 1) i2)) (- 26))
                      (<= (+ i3 i3) (- 1))
                      (<= (+ i3 i3) 0)
                      (<= (+ i3 (* (- 6) (exp 2 eee1)) (* (- 1) i3)
                          (* 2 i3 (exp 2 eee1)) (* 2 (exp 2 it273))
                          (* 6 (exp 2 eee1))) 3)
                      (<= (+ i3 (* (- 6) (exp 2 eee1)) (* (- 1) i3)
                          (* 2 i3 (exp 2 eee1)) (* 2 (exp 2 it273))
                          (* 6 (exp 2 eee1))) 4)
                      (<= (+ i3 (* (- 3) i3)) (- 2))
                      (<= (+ i3 (* (- 2) i3)) 2)
                      (<= (* (- 1) i3) (- 5))
                      (<= (* (- 1) i3) (- 4))
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) it273) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
