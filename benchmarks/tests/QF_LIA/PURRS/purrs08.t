purrs08
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs08.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) n))
                      (= eee1 (+ (- 2) n))
                      (not (= (+ (* n x1 (exp 1 n)) (* n x1 (exp 1 eee1))
                              (* x0 (exp 1 n)) (* x0 (exp 1 eee1))
                              (* (- 4) x0 (exp 1 n))
                              (* (- 2) n x1 (exp 1 eee2))
                              (* (- 2) x1 (exp 1 eee1))
                              (* (- 1) n x0 (exp 1 n))
                              (* (- 1) n x0 (exp 1 eee1))
                              (* 2 n x0 (exp 1 eee2)) (* 2 x0 (exp 1 eee1))
                              (* 2 x1 (exp 1 n))) 0))
                      (<= 2 n))
  Non linear arithmetic between
    0) n
    1) x0
    2) (exp 1 eee1)
    
  Non linear arithmetic between
    0) n
    1) x0
    2) (exp 1 eee2)
    
  Non linear arithmetic between
    0) n
    1) x0
    2) (exp 1 n)
    
  Non linear arithmetic between
    0) n
    1) x1
    2) (exp 1 eee1)
    
  Non linear arithmetic between
    0) n
    1) x1
    2) (exp 1 eee2)
    
  Non linear arithmetic between
    0) n
    1) x1
    2) (exp 1 n)
    
  Non linear arithmetic between
    0) x0
    1) (exp 1 eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp 1 n)
    
  Non linear arithmetic between
    0) x1
    1) (exp 1 eee1)
    
  Non linear arithmetic between
    0) x1
    1) (exp 1 n)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
