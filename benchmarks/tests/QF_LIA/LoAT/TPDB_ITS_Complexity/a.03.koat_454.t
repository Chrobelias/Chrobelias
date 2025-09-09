a.03.koat_454
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_454.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee4)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee5)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee6)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee7)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee8)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee9)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee10)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee11)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee12)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee13)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee14)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee15)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee16)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee17)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee18)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee19)
    
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee20)
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it57))
                      (= eee1 (+ 1 it134))
                      (= (+ it826 (* (- 3) i3) (* (- 1) i2)) (- 4))
                      (= (+ it836 (* (- 1) it134) (* (- 1) it826)) 0)
                      (= (+ it839 (* (- 2) (exp 2 it134))) (- 1))
                      (= (+ it840 (* (- 2) (exp 2 it134))
                         (* (- 1) (exp 2 eee1))) (- 2))
                      (<= (+ it840 (* (- 1) i4)) (- 1))
                      (<= (+ it840 (* (- 1) i4)) 0)
                      (<= (+ (* it840 (exp 2 eee2)) (* (- 1) i4)) (- 1))
                      (<= (+ (* it840 (exp 2 eee2)) (* (- 1) i4)) 0)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 1)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 2)
                      (<= (+ (* (- 1) i4) (exp 2 it134) (exp 2 it134)) 1)
                      (<= (+ (* (- 1) i4) (exp 2 it134) (exp 2 it134)) 2)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it134) (- 1))
                      (<= (* (- 1) it57) (- 1))
                      (<= (* (- 1) it840) (- 1)))
  Non linear arithmetic between
    0) it840
    1) (exp 2 eee2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
