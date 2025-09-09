size02.koat_248
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_248.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i3
    1) it13
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it868 2)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) it868) 2)
    
  Leftover formula:
  (and
                      (= (+ it1145 (* (- 1) it871) (* (- 1) (exp it868 2))
                         (* (- 1) (exp (+ (- 1) it868) 2))) 0)
                      (= (+ it867 (* (- 2) it13) (* (- 1) i2)) 1)
                      (= (+ it868 (* (- 1) i3) (* 2 it13)) 0)
                      (= (+ (* (- 8) (exp it13 3)) (* (- 6) i3 it13)
                         (* (- 6) it13 (exp i3 2)) (* (- 3) i6) (* (- 1) it13)
                         (* 3 it871) (* 6 (exp it13 2)) (* 12 i3 (exp it13 2))) 0)
                      (= (+ (* (- 1) i4 (exp (- 1) it13)) (* (- 1) it1143)) 0)
                      (= (+ (* (- 1) i5 (exp (- 1) it13)) (* (- 1) it1144)) 0)
                      (<= 1 it868)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it868) (* 2 it872) (* 2 it92)) (- 2))
                      (<= (+ (* (- 1) it868) (* 2 it872) (* 2 it92)) (- 1))
                      (<= (+ (* (- 1) it868) (* 2 it92)) (- 2))
                      (<= (+ (* (- 1) it868) (* 2 it92)) (- 1))
                      (<= (+ (* 2 it872) (* 2 it92)) 0)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it868) (- 2))
                      (<= (* (- 1) it872) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it13
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it868 2)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) it868) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
