loop39.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/loop39.koat_1.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it11))
                      (= (+ it14 (* (- 1) i2) (* (- 1) it11)) 1)
                      (= (+ it15 (* (- 1) i3 (exp 2 it11))) 0)
                      (= (* (- 1) it15) 0)
                      (<= (+ i3 (* (- 1) i4)) 1)
                      (<= (+ it15 (* (- 1) i5)) 1)
                      (<= (+ (* i3 (exp 2 eee1)) (* (- 1) i5)) 1)
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) it11) (- 1))
                      (<= (* (- 1) it15) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) i3
    1) (exp 2 it11)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
