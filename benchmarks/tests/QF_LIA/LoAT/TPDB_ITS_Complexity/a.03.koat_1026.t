a.03.koat_1026
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_1026.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it134))
                      (= (+ it1238 (* (- 3) i3) (* (- 1) i2)) (- 4))
                      (= (+ it2562 (* (- 1) it1238) (* (- 1) it57)) 0)
                      (= (+ it2565 (* (- 1) (exp 2 it57))) 0)
                      (= (+ it2566 (* (- 2) (exp 2 it57))) 0)
                      (<= i4 4)
                      (<= (+ i4 (* (- 2) i3)) (- 2))
                      (<= (+ it2566 (* (- 1) i4)) (- 1))
                      (<= (+ it2566 (* (- 1) i4)) 0)
                      (<= (+ (* it2566 (exp 2 eee1)) (* (- 1) i4)
                          (exp 2 it134)) 1)
                      (<= (+ (* it2566 (exp 2 eee1)) (* (- 1) i4)
                          (exp 2 it134)) 2)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 2)
                      (<= (+ (* (- 1) i4) (exp 2 it57)) (- 1))
                      (<= (+ (* (- 1) i4) (exp 2 it57)) 0)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it134) (- 1))
                      (<= (* (- 1) it2566) (- 1))
                      (<= (* (- 1) it57) (- 1)))
  Non linear arithmetic between
    0) it2566
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
