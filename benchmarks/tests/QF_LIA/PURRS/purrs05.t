purrs05
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs05.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) x
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) x
    1) (exp 2 n)
    
  Something weird: no errors. lib/SimplII.ml 897
  Leftover formula:
  (and
                      (not (= (* (- 4) (exp 3 n)) 0))
                      (<= 1 n))
  
  UNKNOWN (Errors after simplification)
  TIMEOUT
