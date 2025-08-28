twn16.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn16.koat_1.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it7))
                      (= (+ it10 (* (- 1) i2) (* (- 1) it7)) 1)
                      (= (+ it11 (* (- 1) i3 (exp 17 it7))) 0)
                      (<= it11 41)
                      (<= 1 i3)
                      (<= 1 it11)
                      (<= (* i3 (exp 17 eee1)) 41)
                      (<= (* (- 1) it7) (- 1))
                      (<= (* 16 it11) 0))
  Non linear arithmetic between
    0) i3
    1) (exp 17 eee1)
    
  Non linear arithmetic between
    0) i3
    1) (exp 17 it7)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
