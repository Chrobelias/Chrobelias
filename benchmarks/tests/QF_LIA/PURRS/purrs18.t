purrs18
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs18.smt2 -bound 0 || echo TIMEOUT
  Leftover formula:
  (and
                      (not (= (+ (* (- 15) x0 (exp 2 (+ (- 1) n)))
                              (* (- 12) x0 (exp 3 (+ (- 2) n)))
                              (* (- 6) x1 (exp 2 (+ (- 2) n)))
                              (* (- 4) x1 (exp 3 n)) (* (- 2) x0 (exp 3 n))
                              (* (- 1) x1 (exp 2 n)) (* 3 x0 (exp 2 n))
                              (* 5 x1 (exp 2 (+ (- 1) n)))
                              (* 6 x1 (exp 3 (+ (- 2) n)))
                              (* 10 x0 (exp 3 (+ (- 1) n)))
                              (* 18 x0 (exp 2 (+ (- 2) n)))) 0))
                      (<= 2 n))
  Non linear arithmetic between
    0) x0
    1) (exp 2 n)
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 (+ (- 2) n))
    
  Non linear arithmetic between
    0) x0
    1) (exp 2 (+ (- 1) n))
    
  Non linear arithmetic between
    0) x0
    1) (exp 3 n)
    
  Non linear arithmetic between
    0) x0
    1) (exp 3 (+ (- 2) n))
    
  Non linear arithmetic between
    0) x0
    1) (exp 3 (+ (- 1) n))
    
  Non linear arithmetic between
    0) x1
    1) (exp 2 n)
    
  Non linear arithmetic between
    0) x1
    1) (exp 2 (+ (- 2) n))
    
  Non linear arithmetic between
    0) x1
    1) (exp 2 (+ (- 1) n))
    
  Non linear arithmetic between
    0) x1
    1) (exp 3 n)
    
  Non linear arithmetic between
    0) x1
    1) (exp 3 (+ (- 2) n))
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
