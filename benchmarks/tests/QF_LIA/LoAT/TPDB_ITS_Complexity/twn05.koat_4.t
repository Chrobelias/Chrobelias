twn05.koat_4
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn05.koat_4.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it122))
                      (= eee1 (+ (- 2) (* 2 it122)))
                      (= (+ it274 (* (- 5) i6) (* (- 1) (exp i5 2))) 0)
                      (<= i5 0)
                      (<= 1 i6)
                      (<= 1 i8)
                      (<= 1 it274)
                      (<= (+ i6 (* (- 1) (exp i7 2))) (- 1))
                      (<= (+ (* (- 16) (exp i7 2) (exp 2 eee1))
                          (* (- 1) (exp i5 2)) (* 4 it274 (exp 5 eee2))
                          (* (exp i5 2) (exp 5 eee2))) (- 1))
                      (<= (* (- 1) it122) (- 1)))
  Non linear arithmetic between
    0) it274
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i5 2)
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i7 2)
    
  Non linear arithmetic between
    0) (exp i7 2)
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
