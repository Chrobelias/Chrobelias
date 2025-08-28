realheapsort.c.koat_2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort.c.koat_2.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (- 1) it624))
                      (= (+ it185 (* (- 6) it182) (* (- 1) i2)) 5)
                      (= (* (- 1) i5) (- 3))
                      (<= i5 (- 3))
                      (<= 0 it6)
                      (<= (+ i5 (* (- 2) i5)) 3)
                      (<= (+ i5 (* (- 2) i5 (exp 2 eee1))
                          (* (- 1) (exp 2 it624))) 1)
                      (<= (+ i5 (* (- 1) it182)) 1)
                      (<= (+ it182 (* (- 2) it6)) 2)
                      (<= (+ it182 (* (- 1) i5)) (- 1))
                      (<= (+ (* (- 1) i5) (* 2 i5 (exp 2 eee1)) (exp 2 it624)) (- 1))
                      (<= (* (- 2) it6) 1)
                      (<= (* (- 1) i5) (- 3))
                      (<= (* (- 1) i5) (- 2))
                      (<= (* (- 1) it182) (- 1))
                      (<= (* (- 1) it624) (- 1))
                      (<= (* 2 it6) 0))
  Non linear arithmetic between
    0) i5
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
