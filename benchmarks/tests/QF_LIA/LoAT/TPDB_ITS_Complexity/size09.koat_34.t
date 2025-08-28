size09.koat_34
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_34.smt2 || echo TIMEOUT
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
                      (= (+ it219 (* (- 4) it202) (* (- 1) it194)) 0)
                      (= (+ it220 (* (- 1) it199) (* 2 it202)) 1)
                      (= (+ it221 (* (- 2) it199) (* 4 it202)) 2)
                      (= (+ it222 (* (- 3) it199) (* 6 it202)) 3)
                      (= (+ it223 (* (- 1) it199) (* 2 it202)) 2)
                      (= (+ it224 (* (- 1) it199) (* 2 it202)) 0)
                      (= (+ it256 (* (- 2) it201) (* (- 1) it219)) 0)
                      (= (+ it257 (* (- 1) it220) (* 2 it201)) 0)
                      (= (+ it257 (* (- 1) it224) (* 2 it225)) 1)
                      (= (+ it258 (* (- 1) it221 (exp (- 1) it201))) 0)
                      (= (+ it259 (* (- 1) it222 (exp (- 1) it201))) 0)
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
                      (= (+ (* (- 8) (exp it201 3)) (* (- 6) it201 it220)
                         (* (- 6) it201 (exp it220 2)) (* (- 3) it223)
                         (* (- 1) it201) (* 3 it260) (* 6 (exp it201 2))
                         (* 12 it220 (exp it201 2))) 0)
                      (= (* 2 it225) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it199)
                      (<= 1 it224)
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
                      (<= (+ (* (- 1) it220) (* 2 it201)) 0)
                      (<= (+ (* (- 1) it220) (* 2 it201)) 1)
                      (<= (+ (* (- 1) it224) (* 2 it225)) 0)
                      (<= (+ (* (- 1) it224) (* 2 it225)) 1)
                      (<= (+ (* (- 1) it257) (* 2 it15)) 0)
                      (<= (+ (* (- 1) it257) (* 2 it15)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it15) (- 1))
                      (<= (* (- 1) it160) (- 1))
                      (<= (* (- 1) it190) (- 1))
                      (<= (* (- 1) it199) (- 2))
                      (<= (* (- 1) it201) (- 1))
                      (<= (* (- 1) it202) (- 1))
                      (<= (* (- 1) it224) (- 2))
                      (<= (* (- 1) it225) (- 1))
                      (<= (* (- 1) it81) (- 1))
                      (<= (* 2 it225) 0))
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
    0) it201
    1) it220
    
  Non linear arithmetic between
    0) it201
    1) (exp it220 2)
    
  Non linear arithmetic between
    0) it220
    1) (exp it201 2)
    
  Non linear arithmetic between
    0) it221
    1) (exp (- 1) it201)
    
  Non linear arithmetic between
    0) it222
    1) (exp (- 1) it201)
    
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
    0) (exp it201 2)
    
  Non linear arithmetic between
    0) (exp it201 3)
    
  Non linear arithmetic between
    0) (exp it220 2)
    
  Non linear arithmetic between
    0) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
