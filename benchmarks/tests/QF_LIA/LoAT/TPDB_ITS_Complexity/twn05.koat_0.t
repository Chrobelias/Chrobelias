twn05.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn05.koat_0.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it122))
                      (= eee1 (+ (- 2) (* 2 it122)))
                      (= (+ it52 (* (- 5) it50) (* (- 2) i8 it50) (* (- 1) i2)
                         (* 2 (exp it50 2))) 1)
                      (= (+ it58 (* (- 1) i8) (* 2 it50)) 0)
                      (= (+ (* (- 1) i8)
                         (* (- 1) (exp (+ (- 1) (* (- 1) i8) (* 2 it50)) 2))
                         (* 2 it50) (* 2 it53)) 1)
                      (<= 0 (* (- 1) i5))
                      (<= 1 i8)
                      (<= 1 it53)
                      (<= (+ (* (- 4) (exp i7 2) (exp 2 eee1))
                          (* 4 it53 (exp 5 eee2))) (- 1))
                      (<= (+ (* (- 1) i8) (* 2 it50)) 0)
                      (<= (+ (* (- 1) i8) (* 2 it50)) 1)
                      (<= (* (- 1) i8) (- 2))
                      (<= (* (- 1) i8) (- 1))
                      (<= (* (- 1) it122) (- 1))
                      (<= (* (- 1) it50) (- 1)))
  Non linear arithmetic between
    0) i8
    1) it50
    
  Non linear arithmetic between
    0) it53
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i7 2)
    
  Non linear arithmetic between
    0) (exp i7 2)
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) (exp it50 2)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) (* (- 1) i8) (* 2 it50)) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
