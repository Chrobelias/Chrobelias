a.03.koat_708
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_708.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ 1 it134))
                      (= eee1 (+ (- 1) it134))
                      (= (+ it1107 (* (- 1) i2) (* (- 1) it134)) 2)
                      (= (+ it1110 (* (- 2) i3 (exp 2 eee1))
                         (* (- 1) (exp 2 it134)) (exp 2 it134)) (- 1))
                      (= (+ it1111 (* (- 2) i3 (exp 2 it134))
                         (* (- 1) (exp 2 eee2)) (* 2 (exp 2 it134))) (- 2))
                      (= (+ it1117 (* (- 3) i3) (* (- 1) it1107)) (- 6))
                      (<= it88 (- 1))
                      (<= (+ it1111 (* (- 1) i4)) (- 1))
                      (<= (+ it1111 (* (- 1) i4)) 0)
                      (<= (+ it88 (* (- 1) i4)) (- 3))
                      (<= (+ it88 (* (- 1) i4)) (- 2))
                      (<= (+ it88 (* (- 1) i4)) (- 1))
                      (<= (+ it88 (* (- 1) i4) (* (- 1) it88)) (- 2))
                      (<= (+ it88 (* (- 1) i4) (* (- 1) it88)) (- 1))
                      (<= (+ (* (- 1) i4) (* (- 1) (exp 2 it134))
                          (* 2 i3 (exp 2 eee1)) (exp 2 it134)) 1)
                      (<= (+ (* (- 1) i4) (* (- 1) (exp 2 it134))
                          (* 2 i3 (exp 2 eee1)) (exp 2 it134)) 2)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 1)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 2)
                      (<= (+ (* (- 1) it1111) (* 2 i3)) 4)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it134) (- 1))
                      (<= (* (- 1) it88) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) i3
    1) (exp 2 it134)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
