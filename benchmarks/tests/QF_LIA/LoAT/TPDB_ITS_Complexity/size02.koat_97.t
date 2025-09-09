size02.koat_97
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_97.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i3
    1) it92
    
  Non linear arithmetic between
    0) i3
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  Leftover formula:
  (and
                      (= (+ it445 (* (- 2) it92) (* (- 1) i2)) 1)
                      (= (+ it446 (* (- 1) i3) (* 2 it92)) 0)
                      (= (+ it447 (* (- 1) i4 (exp (- 1) it92))) 0)
                      (= (+ it448 (* (- 1) i5 (exp (- 1) it92))) 0)
                      (= (+ (* (- 8) (exp it92 3)) (* (- 6) i3 it92)
                         (* (- 6) it92 (exp i3 2)) (* (- 3) i6) (* (- 1) it92)
                         (* 3 it449) (* 6 (exp it92 2)) (* 12 i3 (exp it92 2))) 0)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 1)
                      (<= (+ (* (- 1) it446) (* 2 it13)) 0)
                      (<= (+ (* (- 1) it446) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it446) (* 2 it13) (* 2 it450)) 0)
                      (<= (+ (* (- 1) it446) (* 2 it13) (* 2 it450)) 1)
                      (<= (+ (* 2 it13) (* 2 it450)) 0)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it450) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it92
    
  Non linear arithmetic between
    0) i3
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
