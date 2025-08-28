ex006.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/ex006.koat_1.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it9))
                      (= (+ it13 (* (- 1) i2) (* (- 1) it9)) 1)
                      (= (+ it14 (* (- 1) i3 (exp 2 it9))) 0)
                      (= (+ it15 (* (- 1) i4 (exp 3 it9))) 0)
                      (= (* (- 2) it15) 0)
                      (= (* (- 1) it14) 0)
                      (<= (+ i3 (* (- 4) i4)) 0)
                      (<= (+ it14 (* (- 4) it15)) 0)
                      (<= (+ it15 (* (- 1) it14)) 0)
                      (<= (+ (* i4 (exp 3 eee1)) (* (- 1) i3 (exp 2 eee1))) 0)
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) i4) (- 1))
                      (<= (* (- 1) it14) (- 1))
                      (<= (* (- 1) it15) (- 1))
                      (<= (* (- 1) it9) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) i3
    1) (exp 2 it9)
    
  Non linear arithmetic between
    0) i4
    1) (exp 3 eee1)
    
  Non linear arithmetic between
    0) i4
    1) (exp 3 it9)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
