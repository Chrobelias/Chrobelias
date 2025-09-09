twn17.koat_9
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn17.koat_9.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it352
    1) (exp 9 eee3)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp 4 eee4)
    
  Non linear arithmetic between
    0) (exp i6 3)
    
  Non linear arithmetic between
    0) (exp i6 3)
    1) (exp 9 eee3)
    
  Non linear arithmetic between
    0) (exp i6 5)
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 2) (* 2 it66)))
                      (= eee1 (+ (- 1) it66))
                      (= (+ it345 (* (- 3) i7) (* 2 (exp i6 3))) 0)
                      (= (+ it352 (* (- 3) it345) (* 2 (exp i6 3))) 0)
                      (<= i6 5)
                      (<= 1 i3)
                      (<= 1 (* 4 i3))
                      (<= 1 (* 8 i3))
                      (<= (+ (* (- 3) it352 (exp 9 eee1)) (* (- 1) (exp i6 3))
                          (* 3 (exp i6 3) (exp 9 eee1))
                          (* 64 (exp i3 2) (exp 4 eee2)) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) i7) (exp i3 2) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) it345) (* 4 (exp i3 2)) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) it352) (* 16 (exp i3 2)) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) it352 (exp 9 eee1)) (* (- 1) (exp i6 3))
                          (* 16 (exp i3 2) (exp 4 eee2))
                          (* (exp i6 3) (exp 9 eee1)) (exp i6 5)) (- 1))
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) i6) 5)
                      (<= (* (- 1) it66) (- 1)))
  Non linear arithmetic between
    0) it352
    1) (exp 9 eee1)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp 4 eee2)
    
  Non linear arithmetic between
    0) (exp i6 3)
    
  Non linear arithmetic between
    0) (exp i6 3)
    1) (exp 9 eee1)
    
  Non linear arithmetic between
    0) (exp i6 5)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
