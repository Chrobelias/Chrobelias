size09.koat_24
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_24.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it194 (* (- 4) it190 it81) (* (- 2) it160 it190)
                         (* (- 1) i2)) 1)
                      (= (+ it195 (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                         (* 2 it190 it81) (* 2 it81)) 1)
                      (= (+ it196 (* (- 4) it81 (exp (- 1) it160))
                         (* (- 2) i7 (exp (- 1) it160))
                         (* (- 2) (exp (- 1) it160))
                         (* 4 it190 it81 (exp (- 1) it160))
                         (* 4 it81 (exp (- 1) it160))) 0)
                      (= (+ it197 (* (- 6) it81 (exp (- 1) it160))
                         (* (- 3) i7 (exp (- 1) it160))
                         (* (- 3) (exp (- 1) it160))
                         (* 6 it190 it81 (exp (- 1) it160))
                         (* 6 it81 (exp (- 1) it160))) 0)
                      (= (+ it199 (* (- 1) i7) (* 2 it190 it81)) 0)
                      (= (+ (* (- 24) it190 it81 (exp it160 2))
                         (* (- 24) it81 (exp it160 2)) (* (- 12) it160 it81)
                         (* (- 8) (exp it160 3)) (* (- 6) i7 it160)
                         (* (- 6) it160)
                         (* (- 6) it160 (exp (+ 1 i7 (* (- 2) it190 it81)) 2))
                         (* (- 6) it81) (* (- 3) i7) (* (- 1) it160)
                         (* 3 it198) (* 6 it190 it81) (* 6 it81)
                         (* 6 (exp it160 2)) (* 12 i7 (exp it160 2))
                         (* 12 it160 it190 it81) (* 12 it160 it81)
                         (* 12 (exp it160 2)) (* 24 it81 (exp it160 2))) 6)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it199)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it81) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it81) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it190 it81)) (- 2))
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it81)) 2)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it199) (* 2 it202)) 0)
                      (<= (+ (* (- 1) it199) (* 2 it202)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it160) (- 1))
                      (<= (* (- 1) it190) (- 1))
                      (<= (* (- 1) it199) (- 2))
                      (<= (* (- 1) it202) (- 1))
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
    0) it160
    1) it190
    
  Non linear arithmetic between
    0) it160
    1) it190
    2) it81
    
  Non linear arithmetic between
    0) it160
    1) it81
    
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
    0) it81
    1) (exp it160 2)
    
  Non linear arithmetic between
    0) it81
    1) (exp (- 1) it160)
    
  Non linear arithmetic between
    0) (exp it160 2)
    
  Non linear arithmetic between
    0) (exp it160 3)
    
  Non linear arithmetic between
    0) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
