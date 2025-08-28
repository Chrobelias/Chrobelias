twn19.koat_2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn19.koat_2.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 2) (* 2 it18)))
                      (= eee1 (+ (- 1) it18))
                      (= (+ it23 (* (- 3) i4) (* 2 (exp i5 3))) 0)
                      (= (+ it40 (* (- 3) it23) (* 2 (exp i5 3))) 0)
                      (<= 1 i3)
                      (<= 1 i5)
                      (<= 1 (* 4 i3))
                      (<= 1 (* 8 i3))
                      (<= (+ (* (- 3) it40 (exp 9 eee1)) (* (- 1) (exp i5 3))
                          (* 3 (exp i5 3) (exp 9 eee1))
                          (* 64 (exp i3 2) (exp 4 eee2)) (exp i5 5)) (- 1))
                      (<= (+ (* (- 1) i4) (exp i3 2) (exp i5 5)) (- 1))
                      (<= (+ (* (- 1) it23) (* 4 (exp i3 2)) (exp i5 5)) (- 1))
                      (<= (+ (* (- 1) it40) (* 16 (exp i3 2)) (exp i5 5)) (- 1))
                      (<= (+ (* (- 1) it40 (exp 9 eee1)) (* (- 1) (exp i5 3))
                          (* 16 (exp i3 2) (exp 4 eee2))
                          (* (exp i5 3) (exp 9 eee1)) (exp i5 5)) (- 1))
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) it18) (- 1)))
  Non linear arithmetic between
    0) it40
    1) (exp 9 eee1)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp 4 eee2)
    
  Non linear arithmetic between
    0) (exp i5 3)
    
  Non linear arithmetic between
    0) (exp i5 3)
    1) (exp 9 eee1)
    
  Non linear arithmetic between
    0) (exp i5 5)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
