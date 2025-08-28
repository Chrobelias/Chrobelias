a.03.koat_431
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_431.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it57))
                      (= eee1 (+ 1 it134))
                      (= (+ it365 (* (- 3) i3) (* (- 1) i2)) (- 4))
                      (= (+ it702 (* (- 1) it134) (* (- 1) it365)) 0)
                      (= (+ it705 (* (- 2) (exp 2 it134))) (- 1))
                      (= (+ it706 (* (- 2) (exp 2 it134))
                         (* (- 1) (exp 2 eee1))) (- 2))
                      (<= i4 4)
                      (<= (+ i4 (* (- 2) i3)) (- 2))
                      (<= (+ it706 (* (- 1) i4)) (- 1))
                      (<= (+ it706 (* (- 1) i4)) 0)
                      (<= (+ (* it706 (exp 2 eee2)) (* (- 1) i4)) (- 1))
                      (<= (+ (* it706 (exp 2 eee2)) (* (- 1) i4)) 0)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 2)
                      (<= (+ (* (- 1) i4) (exp 2 it134) (exp 2 it134)) 1)
                      (<= (+ (* (- 1) i4) (exp 2 it134) (exp 2 it134)) 2)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it134) (- 1))
                      (<= (* (- 1) it57) (- 1))
                      (<= (* (- 1) it706) (- 1)))
  Non linear arithmetic between
    0) it706
    1) (exp 2 eee2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
