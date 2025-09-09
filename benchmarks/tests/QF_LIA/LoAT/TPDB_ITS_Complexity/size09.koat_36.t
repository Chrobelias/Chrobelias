size09.koat_36
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_36.smt2 || echo TIMEOUT
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
    0) (exp it160 2)
    
  Non linear arithmetic between
    0) (exp it160 3)
    
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
                      (= (+ it219 (* (- 4) it202) (* (- 1) it194)) 0)
                      (= (+ it220 (* (- 1) it199) (* 2 it202)) 1)
                      (= (+ it221 (* (- 2) it199) (* 4 it202)) 2)
                      (= (+ it222 (* (- 3) it199) (* 6 it202)) 3)
                      (= (+ it223 (* (- 1) it199) (* 2 it202)) 2)
                      (= (+ it224 (* (- 1) it199) (* 2 it202)) 0)
                      (= (+ (* (- 24) it190 it81 (exp it160 2))
                         (* (- 8) (exp it160 3)) (* (- 7) it160)
                         (* (- 6) i7 it160)
                         (* (- 6) it160 (exp (+ 1 i7 (* (- 2) it190 it81)) 2))
                         (* (- 3) i7) (* 3 it198) (* 6 it190 it81)
                         (* 12 i7 (exp it160 2)) (* 12 it160 it190 it81)
                         (* 18 (exp it160 2))) 6)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it199)
                      (<= 1 it220)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it190 it81)) (- 2))
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it190 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it190 it81)) 2)
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
    0) (exp it160 2)
    
  Non linear arithmetic between
    0) (exp it160 3)
    
  Non linear arithmetic between
    0) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
