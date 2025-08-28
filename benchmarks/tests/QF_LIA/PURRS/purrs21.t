purrs21
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs21.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) n))
                      (not (= (+ (* x0 (exp 3 n)) (* (- 3) x0 (exp 3 eee1))
                              (* (- 1) (exp 3 n)) (exp 3 n)) 0))
                      (<= 1 n))
  Non linear arithmetic between
    0) x0
    1) (exp 3 eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp 3 n)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
