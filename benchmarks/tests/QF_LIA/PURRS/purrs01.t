purrs01
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs01.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Non linear arithmetic between
    0) x
    1) (exp 2 (- 1))
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 2) n))
                      (= eee1 (+ (- 1) n))
                      (not (= (+ (* n (exp 2 eee1)) (* (- 2) n (exp 2 eee2))
                              (* (- 1) (exp 2 n)) (* 2 (exp 2 eee2))) 0))
                      (<= 1 n))
  Non linear arithmetic between
    0) n
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) n
    1) (exp 2 eee2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
