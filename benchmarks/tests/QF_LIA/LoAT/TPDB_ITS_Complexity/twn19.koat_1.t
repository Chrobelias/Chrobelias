twn19.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn19.koat_1.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 2) (* 2 it35)))
                      (= eee1 (+ (- 1) it35))
                      (= (+ it23 (* (- 3) i4) (* 2 (exp i5 3))) 0)
                      (<= 1 i3)
                      (<= 1 i5)
                      (<= 1 (* 2 i3))
                      (<= 1 (* 4 i3))
                      (<= (+ (* (- 3) it23 (exp 9 eee1)) (* (- 1) (exp i5 3))
                          (* 3 (exp i5 3) (exp 9 eee1))
                          (* 16 (exp i3 2) (exp 4 eee2)) (exp i5 5)) (- 1))
                      (<= (+ (* (- 1) i4) (exp i3 2) (exp i5 5)) (- 1))
                      (<= (+ (* (- 1) it23) (* 4 (exp i3 2)) (exp i5 5)) (- 1))
                      (<= (+ (* (- 1) it23 (exp 9 eee1)) (* (- 1) (exp i5 3))
                          (* 4 (exp i3 2) (exp 4 eee2))
                          (* (exp i5 3) (exp 9 eee1)) (exp i5 5)) (- 1))
                      (<= (* (- 1) it35) (- 1)))
  Non linear arithmetic between
    0) it23
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
