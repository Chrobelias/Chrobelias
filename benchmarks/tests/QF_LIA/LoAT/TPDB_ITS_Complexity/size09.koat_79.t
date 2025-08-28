size09.koat_79
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_79.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it433 (* (- 4) it190 it425 it81)
                         (* (- 4) it373 it424 it425) (* (- 2) it15 it373 it425)
                         (* (- 2) it160 it190 it425) (* (- 1) i2)) 1)
                      (= (+ it434 (* (- 2) it190 it81) (* (- 2) it373 it424)
                         (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                         (* 2 it190 it425 it81) (* 2 it190 it81)
                         (* 2 it373 it424) (* 2 it373 it424 it425) (* 2 it424)) 1)
                      (= (+ it435 (* (- 4) it190 it81 (exp (- 1) it15))
                         (* (- 4) it373 it424 (exp (- 1) it15))
                         (* (- 4) it424 (exp (- 1) it15))
                         (* (- 2) i7 (exp (- 1) it15))
                         (* (- 2) (exp (- 1) it15))
                         (* 4 it190 it425 it81 (exp (- 1) it15))
                         (* 4 it190 it81 (exp (- 1) it15))
                         (* 4 it373 it424 it425 (exp (- 1) it15))
                         (* 4 it373 it424 (exp (- 1) it15))
                         (* 4 it424 (exp (- 1) it15))) 0)
                      (= (+ it436 (* (- 6) it190 it81 (exp (- 1) it15))
                         (* (- 6) it373 it424 (exp (- 1) it15))
                         (* (- 6) it424 (exp (- 1) it15))
                         (* (- 3) i7 (exp (- 1) it15))
                         (* (- 3) (exp (- 1) it15))
                         (* 6 it190 it425 it81 (exp (- 1) it15))
                         (* 6 it190 it81 (exp (- 1) it15))
                         (* 6 it373 it424 it425 (exp (- 1) it15))
                         (* 6 it373 it424 (exp (- 1) it15))
                         (* 6 it424 (exp (- 1) it15))) 0)
                      (= (+ it438 (* (- 1) i7) (* 2 it190 it425 it81)
                         (* 2 it373 it424 it425)) 0)
                      (= (+ it535 (* (- 2) it443) (* (- 1) it433)) 0)
                      (= (+ it536 (* (- 1) it434) (* 2 it443)) 0)
                      (= (+ it537 (* (- 1) it435 (exp (- 1) it443))) 0)
                      (= (+ it538 (* (- 1) it436 (exp (- 1) it443))) 0)
                      (= (+ (* (- 24) it190 it425 it81 (exp it15 2))
                         (* (- 24) it190 it81 (exp it15 2))
                         (* (- 24) it373 it424 it425 (exp it15 2))
                         (* (- 24) it373 it424 (exp it15 2))
                         (* (- 24) it424 (exp it15 2))
                         (* (- 12) it15 it190 it81) (* (- 12) it15 it373 it424)
                         (* (- 12) it15 it424) (* (- 8) (exp it15 3))
                         (* (- 6) i7 it15) (* (- 6) it15)
                         (* (- 6) it15
                         (exp (+ (- 1) (* (- 2) it190 it81)
                              (* (- 2) it373 it424) (* (- 2) it424)
                              (* (- 1) i7) (* 2 it190 it425 it81)
                              (* 2 it190 it81) (* 2 it373 it424)
                              (* 2 it373 it424 it425) (* 2 it424)) 2))
                         (* (- 6) it190 it81) (* (- 6) it373 it424)
                         (* (- 6) it424) (* (- 3) i7) (* (- 1) it15)
                         (* 3 it437) (* 6 it190 it425 it81) (* 6 it190 it81)
                         (* 6 it373 it424) (* 6 it373 it424 it425) (* 6 it424)
                         (* 6 (exp it15 2)) (* 12 i7 (exp it15 2))
                         (* 12 it15 it190 it425 it81) (* 12 it15 it190 it81)
                         (* 12 it15 it373 it424) (* 12 it15 it373 it424 it425)
                         (* 12 it15 it424) (* 12 (exp it15 2))
                         (* 24 it190 it81 (exp it15 2))
                         (* 24 it373 it424 (exp it15 2))
                         (* 24 it424 (exp it15 2))) 6)
                      (= (+ (* (- 8) (exp it443 3)) (* (- 6) it434 it443)
                         (* (- 6) it443 (exp it434 2)) (* (- 3) it437)
                         (* (- 1) it443) (* 3 it539) (* 6 (exp it443 2))
                         (* 12 it434 (exp it443 2))) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it373 it424 it425)
                          (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it373 it424 it425)
                          (* 2 it424)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425)) (- 2))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it424)) 0)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it81) (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425)) (- 2))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425) (* 2 it424)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it160) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it160) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)) (- 2))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)) (- 1))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)) 0)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it424)) 0)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425)) (- 2))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 0)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it81) (* 2 it373 it424) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it81) (* 2 it373 it424) (* 2 it424)) 2)
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it190 it81)
                          (* 2 it373 it424)) (- 2))
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it424)) 0)
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it81) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it81) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it190 it81)) (- 2))
                      (<= (+ (* (- 1) i7) (* 2 it15) (* 2 it190 it81)
                          (* 2 it424)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it15) (* 2 it190 it81)
                          (* 2 it424)) 2)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it81)) 2)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) (- 2))
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) (- 1))
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81) (* 2 it424)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81) (* 2 it424)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it434) (* 2 it443)) 0)
                      (<= (+ (* (- 1) it434) (* 2 it443)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it15) (- 1))
                      (<= (* (- 1) it160) (- 1))
                      (<= (* (- 1) it190) (- 1))
                      (<= (* (- 1) it373) (- 1))
                      (<= (* (- 1) it424) (- 1))
                      (<= (* (- 1) it425) (- 1))
                      (<= (* (- 1) it443) (- 1))
                      (<= (* (- 1) it81) (- 1)))
  Non linear arithmetic between
    0) i7
    1) it15
    
  Non linear arithmetic between
    0) i7
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) i7
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it15
    1) it190
    2) it425
    3) it81
    
  Non linear arithmetic between
    0) it15
    1) it190
    2) it81
    
  Non linear arithmetic between
    0) it15
    1) it373
    2) it424
    
  Non linear arithmetic between
    0) it15
    1) it373
    2) it424
    3) it425
    
  Non linear arithmetic between
    0) it15
    1) it373
    2) it425
    
  Non linear arithmetic between
    0) it15
    1) it424
    
  Non linear arithmetic between
    0) it15
    1) (exp (+ (- 1) (* (- 2) it190 it81) (* (- 2) it373 it424) (* (- 2) it424)
            (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
            (* 2 it373 it424) (* 2 it373 it424 it425) (* 2 it424)) 2)
    
  Non linear arithmetic between
    0) it160
    1) it190
    2) it425
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it81
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it81
    3) (exp it15 2)
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it81
    3) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it190
    1) it81
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp it15 2)
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it373
    1) it424
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) (exp it15 2)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) (exp it15 2)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it424
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) it424
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it434
    1) it443
    
  Non linear arithmetic between
    0) it434
    1) (exp it443 2)
    
  Non linear arithmetic between
    0) it435
    1) (exp (- 1) it443)
    
  Non linear arithmetic between
    0) it436
    1) (exp (- 1) it443)
    
  Non linear arithmetic between
    0) it443
    1) (exp it434 2)
    
  Non linear arithmetic between
    0) (exp it15 2)
    
  Non linear arithmetic between
    0) (exp it15 3)
    
  Non linear arithmetic between
    0) (exp it434 2)
    
  Non linear arithmetic between
    0) (exp it443 2)
    
  Non linear arithmetic between
    0) (exp it443 3)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) (* (- 2) it190 it81) (* (- 2) it373 it424) (* (- 2) it424)
            (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
            (* 2 it373 it424) (* 2 it373 it424 it425) (* 2 it424)) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
