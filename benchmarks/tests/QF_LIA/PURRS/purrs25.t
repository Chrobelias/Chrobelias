purrs25
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs25.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) n))
                      (not (= (+ (* n (exp 2 n)) (* x0 (exp 2 n))
                              (* (- 2) n (exp 2 eee1))
                              (* (- 2) x0 (exp 2 eee1)) (* (- 2) (exp 2 n))
                              (* 4 (exp 2 eee1))) 0))
                      (<= 1 n))
  Non linear arithmetic between
    0) n
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) n
    1) (exp 2 n)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 n)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
