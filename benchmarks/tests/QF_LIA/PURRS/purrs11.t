purrs11
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs11.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee3 (+ (- 3) n))
                      (= eee2 (+ (- 2) n))
                      (= eee1 (+ (- 1) n))
                      (not (= (+ (* n n (exp 2 eee1)) (* n x1 (exp 2 eee1))
                              (* (- 16) x0 (exp 2 eee2))
                              (* (- 12) n (exp 2 eee3))
                              (* (- 8) n x0 (exp 2 eee3))
                              (* (- 8) n (exp 2 eee3))
                              (* (- 8) x1 (exp 2 eee3)) (* (- 8) (exp 2 eee2))
                              (* (- 4) n n (exp 2 eee2))
                              (* (- 4) n x1 (exp 2 eee2))
                              (* (- 2) n x0 (exp 2 eee1))
                              (* (- 1) n (exp 2 eee1)) (* (- 1) (exp 2 n))
                              (* 2 x0 (exp 2 eee1)) (* 4 n n (exp 2 eee3))
                              (* 4 n x1 (exp 2 eee3)) (* 4 n (exp 2 eee2))
                              (* 4 x1 (exp 2 eee2)) (* 8 n x0 (exp 2 eee2))
                              (* 8 n (exp 2 eee2)) (* 24 x0 (exp 2 eee3))
                              (* 24 (exp 2 eee3))) 0))
                      (<= 3 n))
  Non linear arithmetic between
    0) n
    1) n
    2) (exp 2 eee1)
    
  Non linear arithmetic between
    0) n
    1) n
    2) (exp 2 eee2)
    
  Non linear arithmetic between
    0) n
    1) n
    2) (exp 2 eee3)
    
  Non linear arithmetic between
    0) n
    1) x0
    2) (exp 2 eee1)
    
  Non linear arithmetic between
    0) n
    1) x0
    2) (exp 2 eee2)
    
  Non linear arithmetic between
    0) n
    1) x0
    2) (exp 2 eee3)
    
  Non linear arithmetic between
    0) n
    1) x1
    2) (exp 2 eee1)
    
  Non linear arithmetic between
    0) n
    1) x1
    2) (exp 2 eee2)
    
  Non linear arithmetic between
    0) n
    1) x1
    2) (exp 2 eee3)
    
  Non linear arithmetic between
    0) n
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) n
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) n
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) x1
    1) (exp 2 eee2)
    
  Non linear arithmetic between
    0) x1
    1) (exp 2 eee3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
