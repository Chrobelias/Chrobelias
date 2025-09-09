size09.koat_55
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_55.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i7
    1) it160
    
  Non linear arithmetic between
    0) i7
    1) (exp it160 2)
    
  Non linear arithmetic between
    0) i7
    1) (exp (- 1) it160)
    
  Non linear arithmetic between
    0) it15
    1) it199
    
  Non linear arithmetic between
    0) it15
    1) it202
    2) it373
    
  Non linear arithmetic between
    0) it15
    1) it373
    
  Non linear arithmetic between
    0) it15
    1) (exp (+ (- 1) (* (- 1) it199) (* 2 it202 it373)) 2)
    
  Non linear arithmetic between
    0) it160
    1) it190
    
  Non linear arithmetic between
    0) it160
    1) it190
    2) it81
    
  Non linear arithmetic between
    0) it160
    1) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  Non linear arithmetic between
    0) it190
    1) it81
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp it160 2)
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp (- 1) it160)
    
  Non linear arithmetic between
    0) it199
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) it199
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it202
    1) it373
    
  Non linear arithmetic between
    0) it202
    1) it373
    2) (exp it15 2)
    
  Non linear arithmetic between
    0) it202
    1) it373
    2) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) (exp it15 2)
    
  Non linear arithmetic between
    0) (exp it15 3)
    
  Non linear arithmetic between
    0) (exp it160 2)
    
  Non linear arithmetic between
    0) (exp it160 3)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) (* (- 1) it199) (* 2 it202 it373)) 2)
    
  Non linear arithmetic between
    0) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  Leftover formula:
  (and
                      (= (+ it194 (* (- 4) it190 it81) (* (- 2) it160 it190)
                         (* (- 1) i2)) 1)
                      (= (+ it195 (* (- 1) i7) (* 2 it160) (* 2 it190 it81)) 1)
                      (= (+ it196 (* (- 2) i7 (exp (- 1) it160))
                         (* (- 2) (exp (- 1) it160))
                         (* 4 it190 it81 (exp (- 1) it160))) 0)
                      (= (+ it197 (* (- 3) i7 (exp (- 1) it160))
                         (* (- 3) (exp (- 1) it160))
                         (* 6 it190 it81 (exp (- 1) it160))) 0)
                      (= (+ it199 (* (- 1) i7) (* 2 it190 it81)) 0)
                      (= (+ it377 (* (- 4) it202 it373) (* (- 2) it15 it373)
                         (* (- 1) it194)) 0)
                      (= (+ it378 (* (- 1) it199) (* 2 it15) (* 2 it202 it373)) 1)
                      (= (+ it379 (* (- 2) it199 (exp (- 1) it15))
                         (* (- 2) (exp (- 1) it15))
                         (* 4 it202 it373 (exp (- 1) it15))) 0)
                      (= (+ it380 (* (- 3) it199 (exp (- 1) it15))
                         (* (- 3) (exp (- 1) it15))
                         (* 6 it202 it373 (exp (- 1) it15))) 0)
                      (= (+ it382 (* (- 1) it199) (* 2 it202 it373)) 0)
                      (= (+ (* (- 24) it190 it81 (exp it160 2))
                         (* (- 8) (exp it160 3)) (* (- 7) it160)
                         (* (- 6) i7 it160)
                         (* (- 6) it160 (exp (+ 1 i7 (* (- 2) it190 it81)) 2))
                         (* (- 3) i7) (* 3 it198) (* 6 it190 it81)
                         (* 12 i7 (exp it160 2)) (* 12 it160 it190 it81)
                         (* 18 (exp it160 2))) 6)
                      (= (+ (* (- 24) it202 it373 (exp it15 2))
                         (* (- 8) (exp it15 3)) (* (- 7) it15)
                         (* (- 6) it15 it199)
                         (* (- 6) it15
                         (exp (+ (- 1) (* (- 1) it199) (* 2 it202 it373)) 2))
                         (* (- 3) it199) (* 3 it381) (* 6 it202 it373)
                         (* 12 it15 it202 it373) (* 12 it199 (exp it15 2))
                         (* 18 (exp it15 2))) 6)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it199)
                      (<= (+ (* (- 2) it202) (* (- 1) it199) (* 2 it202 it373)) (- 2))
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it190 it81)) (- 2))
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it190 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it190 it81)) 2)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it81)) 2)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it199) (* 2 it15) (* 2 it202)) 1)
                      (<= (+ (* (- 1) it199) (* 2 it15) (* 2 it202)) 2)
                      (<= (+ (* (- 1) it199) (* 2 it15) (* 2 it202 it373)) 1)
                      (<= (+ (* (- 1) it199) (* 2 it15) (* 2 it202 it373)) 2)
                      (<= (+ (* (- 1) it199) (* 2 it202)) 0)
                      (<= (+ (* (- 1) it199) (* 2 it202)) 1)
                      (<= (+ (* (- 1) it199) (* 2 it202 it373)) 0)
                      (<= (+ (* (- 1) it199) (* 2 it202 it373)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it15) (- 1))
                      (<= (* (- 1) it160) (- 1))
                      (<= (* (- 1) it190) (- 1))
                      (<= (* (- 1) it199) (- 2))
                      (<= (* (- 1) it202) (- 1))
                      (<= (* (- 1) it373) (- 1))
                      (<= (* (- 1) it81) (- 1)))
  Non linear arithmetic between
    0) i7
    1) it160
    
  Non linear arithmetic between
    0) i7
    1) (exp it160 2)
    
  Non linear arithmetic between
    0) i7
    1) (exp (- 1) it160)
    
  Non linear arithmetic between
    0) it15
    1) it199
    
  Non linear arithmetic between
    0) it15
    1) it202
    2) it373
    
  Non linear arithmetic between
    0) it15
    1) it373
    
  Non linear arithmetic between
    0) it15
    1) (exp (+ (- 1) (* (- 1) it199) (* 2 it202 it373)) 2)
    
  Non linear arithmetic between
    0) it160
    1) it190
    
  Non linear arithmetic between
    0) it160
    1) it190
    2) it81
    
  Non linear arithmetic between
    0) it160
    1) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  Non linear arithmetic between
    0) it190
    1) it81
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp it160 2)
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp (- 1) it160)
    
  Non linear arithmetic between
    0) it199
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) it199
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it202
    1) it373
    
  Non linear arithmetic between
    0) it202
    1) it373
    2) (exp it15 2)
    
  Non linear arithmetic between
    0) it202
    1) it373
    2) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) (exp it15 2)
    
  Non linear arithmetic between
    0) (exp it15 3)
    
  Non linear arithmetic between
    0) (exp it160 2)
    
  Non linear arithmetic between
    0) (exp it160 3)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) (* (- 1) it199) (* 2 it202 it373)) 2)
    
  Non linear arithmetic between
    0) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
