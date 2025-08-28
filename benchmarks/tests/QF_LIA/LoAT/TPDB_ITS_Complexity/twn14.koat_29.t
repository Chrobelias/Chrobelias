twn14.koat_29
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn14.koat_29.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 2) (* 2 it109)))
                      (= eee1 (+ (- 1) it109))
                      (= (+ it553 (* (- 3) i7) (* 2 (exp i6 3))) 0)
                      (= (+ it562 (* (- 3) it553) (* 2 (exp i6 3))) 0)
                      (= (+ it577 (* (- 3) it562) (* 2 (exp i6 3))) 0)
                      (<= 1 i3)
                      (<= 1 i6)
                      (<= 1 (* (- 16) i3))
                      (<= 1 (* (- 8) i3))
                      (<= 1 (* 4 i3))
                      (<= (+ (* (- 3) it577 (exp 9 eee1)) (* (- 1) (exp i6 3))
                          (* 3 (exp i6 3) (exp 9 eee1))
                          (* 256 (exp i3 2) (exp 4 eee2)) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) i7) (exp i3 2) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) it553) (* 4 (exp i3 2)) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) it562) (* 16 (exp i3 2)) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) it577) (* 64 (exp i3 2)) (exp i6 5)) (- 1))
                      (<= (+ (* (- 1) it577 (exp 9 eee1)) (* (- 1) (exp i6 3))
                          (* 64 (exp i3 2) (exp 4 eee2))
                          (* (exp i6 3) (exp 9 eee1)) (exp i6 5)) (- 1))
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) it109) (- 1)))
  Non linear arithmetic between
    0) it577
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
