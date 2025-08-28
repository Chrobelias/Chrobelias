purrs20
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs20.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) n))
                      (not (= (* x0 (exp a n)) (* a x0 (exp a eee1))))
                      (not (= a 0))
                      (<= 1 n))
  Non linear arithmetic between
    0) a
    1) x0
    2) (exp a eee1)
    
  Non linear arithmetic between
    0) x0
    1) (exp a n)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
