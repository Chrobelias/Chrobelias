purrs21
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs21.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) x0
    1) (exp 3 eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp 3 n)
    
  Something weird: no errors. lib/SimplII.ml 897
  Leftover formula:
  (and
                      (not (= (* (- 2) (exp 3 n)) 0))
                      (<= 1 n))
  
  UNKNOWN (Errors after simplification)
  TIMEOUT
