purrs07
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs07.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) a
    1) a
    2) n
    3) x0
    4) (exp a eee4)
    
  Non linear arithmetic between
    0) a
    1) a
    2) n
    3) x1
    4) (exp a eee4)
    
  Non linear arithmetic between
    0) a
    1) a
    2) x0
    3) (exp a eee4)
    
  Non linear arithmetic between
    0) a
    1) a
    2) x1
    3) (exp a eee4)
    
  Non linear arithmetic between
    0) a
    1) n
    2) x0
    3) (exp a eee3)
    
  Non linear arithmetic between
    0) a
    1) n
    2) x1
    3) (exp a eee3)
    
  Non linear arithmetic between
    0) a
    1) x0
    2) (exp a eee3)
    
  Non linear arithmetic between
    0) a
    1) x1
    2) (exp a eee3)
    
  Non linear arithmetic between
    0) n
    1) x0
    2) (exp a n)
    
  Non linear arithmetic between
    0) n
    1) x1
    2) (exp a n)
    
  Non linear arithmetic between
    0) x0
    1) (exp a n)
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) n))
                      (= eee1 (+ (- 2) n))
                      (not (= (+ (* a a n x1 (exp a eee1)) (* n x1 (exp a n))
                              (* x0 (exp a n)) (* (- 4) a x0 (exp a eee2))
                              (* (- 2) a a x1 (exp a eee1))
                              (* (- 2) a n x1 (exp a eee2))
                              (* (- 1) a a n x0 (exp a eee1))
                              (* (- 1) n x0 (exp a n))
                              (* 2 a n x0 (exp a eee2)) (* 2 a x1 (exp a eee2))
                              (* 3 a a x0 (exp a eee1))) 0))
                      (<= 1 a)
                      (<= 2 n))
  Non linear arithmetic between
    0) a
    1) a
    2) n
    3) x0
    4) (exp a eee1)
    
  Non linear arithmetic between
    0) a
    1) a
    2) n
    3) x1
    4) (exp a eee1)
    
  Non linear arithmetic between
    0) a
    1) a
    2) x0
    3) (exp a eee1)
    
  Non linear arithmetic between
    0) a
    1) a
    2) x1
    3) (exp a eee1)
    
  Non linear arithmetic between
    0) a
    1) n
    2) x0
    3) (exp a eee2)
    
  Non linear arithmetic between
    0) a
    1) n
    2) x1
    3) (exp a eee2)
    
  Non linear arithmetic between
    0) a
    1) x0
    2) (exp a eee2)
    
  Non linear arithmetic between
    0) a
    1) x1
    2) (exp a eee2)
    
  Non linear arithmetic between
    0) n
    1) x0
    2) (exp a n)
    
  Non linear arithmetic between
    0) n
    1) x1
    2) (exp a n)
    
  Non linear arithmetic between
    0) x0
    1) (exp a n)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
