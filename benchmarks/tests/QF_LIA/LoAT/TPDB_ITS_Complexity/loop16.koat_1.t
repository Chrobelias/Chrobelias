loop16.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/loop16.koat_1.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it7))
                      (= (+ it10 (* (- 1) i2) (* (- 1) it7)) 1)
                      (= (+ it11 (* (- 10) (exp 2 it7))
                         (* (- 1) i3 (exp 2 it7))) (- 10))
                      (= (* (- 1) it11) 10)
                      (<= it11 99)
                      (<= (+ (* i3 (exp 2 eee1)) (* 10 (exp 2 eee1))) 109)
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) it11) (- 1))
                      (<= (* (- 1) it7) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) i3
    1) (exp 2 it7)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
