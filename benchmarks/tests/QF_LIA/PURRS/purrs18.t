purrs18
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs18.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 2) n))
                      (= eee1 (+ (- 1) n))
                      (not (= (+ (* x1 (exp 3 n)) (* (- 15) x0 (exp 2 eee1))
                              (* (- 12) x0 (exp 3 eee2))
                              (* (- 6) x1 (exp 2 eee2))
                              (* (- 5) x1 (exp 3 eee1)) (* (- 2) x0 (exp 3 n))
                              (* (- 1) x1 (exp 2 n)) (* 3 x0 (exp 2 n))
                              (* 5 x1 (exp 2 eee1)) (* 6 x1 (exp 3 eee2))
                              (* 10 x0 (exp 3 eee1)) (* 18 x0 (exp 2 eee2))) 0))
                      (<= 2 n))
  Non linear arithmetic between
    0) x0
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 n)
    
  Non linear arithmetic between
    0) x0
    1) (exp 3 eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp 3 eee2)
    
  Non linear arithmetic between
    0) x0
    1) (exp 3 n)
    
  Non linear arithmetic between
    0) x1
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) x1
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) x1
    1) (exp 2 n)
    
  Non linear arithmetic between
    0) x1
    1) (exp 3 eee1)
    
  Non linear arithmetic between
    0) x1
    1) (exp 3 eee2)
    
  Non linear arithmetic between
    0) x1
    1) (exp 3 n)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
