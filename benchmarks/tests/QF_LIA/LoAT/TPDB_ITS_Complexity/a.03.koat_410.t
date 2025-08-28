a.03.koat_410
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_410.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it134))
                      (= (+ it365 (* (- 3) i3) (* (- 1) i2)) (- 4))
                      (= (+ it379 (* (- 1) it365) (* (- 1) it57)) 0)
                      (= (+ it382 (* (- 1) (exp 2 it57))) 0)
                      (= (+ it383 (* (- 2) (exp 2 it57))) 0)
                      (<= i4 4)
                      (<= (+ i4 (* (- 2) i3)) (- 2))
                      (<= (+ it383 (* (- 1) i4)) (- 1))
                      (<= (+ it383 (* (- 1) i4)) 0)
                      (<= (+ (* it383 (exp 2 eee1)) (* (- 1) i4) (exp 2 it134)) 1)
                      (<= (+ (* it383 (exp 2 eee1)) (* (- 1) i4) (exp 2 it134)) 2)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 2)
                      (<= (+ (* (- 1) i4) (exp 2 it57)) (- 1))
                      (<= (+ (* (- 1) i4) (exp 2 it57)) 0)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it134) (- 1))
                      (<= (* (- 1) it383) (- 1))
                      (<= (* (- 1) it57) (- 1)))
  Non linear arithmetic between
    0) it383
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
