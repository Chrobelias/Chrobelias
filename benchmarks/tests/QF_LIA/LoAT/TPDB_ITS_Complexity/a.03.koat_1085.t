a.03.koat_1085
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_1085.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it2761 (* (- 1) i2) (* (- 1) it57)) 2)
                      (= (+ it2764 (* (- 1) i3 (exp 2 it57)) (exp 2 it57)) 0)
                      (= (+ it2765 (* (- 2) i3 (exp 2 it57))
                         (* 2 (exp 2 it57))) 0)
                      (= (+ it2804 (* (- 3) i3) (* (- 1) it2761)) (- 6))
                      (<= it88 (- 1))
                      (<= (+ it2765 (* (- 1) i4)) (- 1))
                      (<= (+ it2765 (* (- 1) i4)) 0)
                      (<= (+ it88 (* (- 1) i4)) (- 3))
                      (<= (+ it88 (* (- 1) i4)) (- 2))
                      (<= (+ it88 (* (- 1) i4)) (- 1))
                      (<= (+ (* i3 (exp 2 it57)) (* (- 1) i4)
                          (* (- 1) (exp 2 it57))) (- 1))
                      (<= (+ (* i3 (exp 2 it57)) (* (- 1) i4)
                          (* (- 1) (exp 2 it57))) 0)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 1)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 2)
                      (<= (+ (* (- 1) it2765) (* 2 i3)) 4)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) i4) (- 1))
                      (<= (* (- 1) it57) (- 1))
                      (<= (* (- 1) it88) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 it57)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
