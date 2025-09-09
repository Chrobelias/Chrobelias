a.03.koat_1100
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_1100.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it2761 (* (- 1) i2) (* (- 1) it57)) 2)
                      (= (+ it2764 (* (- 1) i3 (exp 2 it57)) (exp 2 it57)) 0)
                      (= (+ it2765 (* (- 2) i3 (exp 2 it57))
                         (* 2 (exp 2 it57))) 0)
                      (= (+ it2804 (* (- 3) i3) (* (- 1) it2761)) (- 6))
                      (<= it2765 1)
                      (<= it2765 2)
                      (<= (+ (* i3 (exp 2 it57)) (* (- 1) (exp 2 it57))) 1)
                      (<= (+ (* i3 (exp 2 it57)) (* (- 1) (exp 2 it57))) 2)
                      (<= (+ (* (- 1) it2765) (* 2 i3)) 4)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) it57) (- 1))
                      (<= (* 2 i3) 3)
                      (<= (* 2 i3) 4))
  Non linear arithmetic between
    0) i3
    1) (exp 2 it57)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
