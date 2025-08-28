purrs26
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs26.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) n))
                      (not (= (+ (* x0 (exp 2 n)) (* (- 2) x0 (exp 2 eee1))
                              (* (- 1) (exp 2 n)) (exp 2 n)) 0))
                      (<= 1 n))
  Non linear arithmetic between
    0) x0
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 n)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
