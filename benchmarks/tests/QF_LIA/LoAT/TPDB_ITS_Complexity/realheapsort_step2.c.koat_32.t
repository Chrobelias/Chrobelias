realheapsort_step2.c.koat_32
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.c.koat_32.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it101))
                      (= eee1 (+ 1 it316))
                      (= (+ it320 (* (- 6) it316) (* (- 1) i2)) 18)
                      (= (+ it323 (* (- 1) (exp 2 eee1))) (- 2))
                      (= (+ it325 (* (- 2) (exp 2 it316))) (- 2))
                      (= (+ (* (- 1) i4) (* 2 it323)) (- 3))
                      (<= (+ i4 (* (- 4) it323)) 5)
                      (<= (+ i4 (* (- 4) it323 (exp 2 eee2))
                          (* (- 2) (exp 2 it101))) 1)
                      (<= (+ (* (- 1) i4) (* 2 it323)) (- 3))
                      (<= (+ (* (- 1) i4) (* 2 (exp 2 it316))) 0)
                      (<= (+ (* (- 1) i4) (* 2 (exp 2 it316))) 1)
                      (<= (+ (* (- 1) i4) (* 4 it323)) (- 5))
                      (<= (+ (* (- 1) i4) (* 4 it323 (exp 2 eee2))
                          (exp 2 it101) (exp 2 it101)) (- 1))
                      (<= (* (- 1) i4) (- 4))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it101) (- 1))
                      (<= (* (- 1) it316) (- 1)))
  Non linear arithmetic between
    0) it323
    1) (exp 2 eee2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
