a.03.koat_60
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_60.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ 1 it134))
                      (= eee1 (+ (- 1) it134))
                      (= (+ it171 (* (- 1) i2) (* (- 1) it134)) 2)
                      (= (+ it174 (* (- 2) i3 (exp 2 eee1))
                         (* (- 1) (exp 2 it134)) (exp 2 it134)) (- 1))
                      (= (+ it175 (* (- 2) i3 (exp 2 it134))
                         (* (- 1) (exp 2 eee2)) (* 2 (exp 2 it134))) (- 2))
                      (= (* (- 2) i3) (- 2))
                      (<= (+ it175 (* (- 1) i4)) (- 1))
                      (<= (+ it175 (* (- 1) i4)) 0)
                      (<= (+ (* (- 1) i4) (* (- 1) (exp 2 it134))
                          (* 2 i3 (exp 2 eee1)) (exp 2 it134)) 1)
                      (<= (+ (* (- 1) i4) (* (- 1) (exp 2 it134))
                          (* 2 i3 (exp 2 eee1)) (exp 2 it134)) 2)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 1)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 2)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 3)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 4)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it134) (- 1))
                      (<= (* 2 i3) 2))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) i3
    1) (exp 2 it134)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
