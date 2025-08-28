a.03.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it57))
                      (= (+ it19 it23 (* (- 1) i4)) (- 1))
                      (= (+ it21 (* (- 3) it19) (* (- 1) i2)) 2)
                      (<= i3 1)
                      (<= (+ it19 (* (- 1) i4)) (- 3))
                      (<= (+ it19 (* (- 1) i4)) (- 2))
                      (<= (+ it19 (* (- 1) i4) (* 2 i3)) (- 1))
                      (<= (+ it19 (* (- 1) i4) (* 2 i3)) 0)
                      (<= (+ (* (- 1) i4) (* 2 i3)) (- 2))
                      (<= (+ (* (- 1) i4) (* 2 i3)) (- 1))
                      (<= (+ (* (- 1) it23) (* 2 i3)) (- 1))
                      (<= (+ (* (- 1) it23) (* 2 i3)) 0)
                      (<= (+ (* (- 1) it23) (* 2 i3 (exp 2 eee1))) (- 1))
                      (<= (+ (* (- 1) it23) (* 2 i3 (exp 2 eee1))) 0)
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) i4) (- 4))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) it19) (- 1))
                      (<= (* (- 1) it57) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
