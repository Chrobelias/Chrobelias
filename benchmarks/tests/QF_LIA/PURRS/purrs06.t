purrs06
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs06.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) n))
                      (not (= (+ (* x (exp 3 n)) (* (- 6) (exp 3 eee1))
                              (* (- 3) x (exp 3 eee1)) (* (- 3) (exp 2 n))
                              (* 2 (exp 3 n)) (* 6 (exp 2 eee1))) 0))
                      (<= 1 n))
  Non linear arithmetic between
    0) x
    1) (exp 3 eee1)
    
  Non linear arithmetic between
    0) x
    1) (exp 3 n)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
