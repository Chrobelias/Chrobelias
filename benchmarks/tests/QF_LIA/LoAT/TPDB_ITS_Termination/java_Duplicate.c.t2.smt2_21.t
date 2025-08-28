java_Duplicate.c.t2.smt2_21
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/java_Duplicate.c.t2.smt2_21.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it115))
                      (= (+ it247 (* (- 1) i7 (exp 2 eee1))) 0)
                      (= (+ it248 (* (- 1) i8) (* (- 1) it115)) (- 1))
                      (= (+ it251 (* (- 1) i7 (exp 2 it115))) 0)
                      (= (+ it252 (* (- 1) i8) (* (- 1) it115)) 0)
                      (<= it251 0)
                      (<= (+ i7 (* (- 1) i8)) (- 1))
                      (<= (+ it251 (* (- 1) it252)) (- 1))
                      (<= (+ (* i7 (exp 2 eee1)) (* (- 1) i8) (* (- 1) it115)) (- 2))
                      (<= (* (- 1) i7) (- 3))
                      (<= (* (- 1) it115) (- 1))
                      (<= (* (- 1) it251) (- 3)))
  Non linear arithmetic between
    0) i7
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) i7
    1) (exp 2 it115)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
