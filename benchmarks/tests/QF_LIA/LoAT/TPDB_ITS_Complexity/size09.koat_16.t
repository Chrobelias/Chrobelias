size09.koat_16
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_16.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it114 (* (- 4) it81) (* (- 1) i2)) 1)
                      (= (+ it115 (* (- 1) i7) (* 2 it81)) 1)
                      (= (+ it116 (* (- 2) i7) (* 4 it81)) 2)
                      (= (+ it117 (* (- 3) i7) (* 6 it81)) 3)
                      (= (+ it118 (* (- 1) i7) (* 2 it81)) 2)
                      (= (+ it119 (* (- 1) i7) (* 2 it81)) 0)
                      (= (+ it162 (* (- 2) it160) (* (- 1) it114)) 0)
                      (= (+ it163 (* (- 1) it115) (* 2 it160)) 0)
                      (= (+ it163 (* (- 1) it119) (* 2 it120)) 1)
                      (= (+ it164 (* (- 1) it116 (exp (- 1) it160))) 0)
                      (= (+ it165 (* (- 1) it117 (exp (- 1) it160))) 0)
                      (= (+ (* (- 8) (exp it160 3)) (* (- 6) it115 it160)
                         (* (- 6) it160 (exp it115 2)) (* (- 3) it118)
                         (* (- 1) it160) (* 3 it166) (* 6 (exp it160 2))
                         (* 12 it115 (exp it160 2))) 0)
                      (= (* 2 it120) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it119)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it115) (* 2 it160)) 0)
                      (<= (+ (* (- 1) it115) (* 2 it160)) 1)
                      (<= (+ (* (- 1) it119) (* 2 it120)) 0)
                      (<= (+ (* (- 1) it119) (* 2 it120)) 1)
                      (<= (+ (* (- 1) it163) (* 2 it15)) 0)
                      (<= (+ (* (- 1) it163) (* 2 it15)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it119) (- 2))
                      (<= (* (- 1) it120) (- 1))
                      (<= (* (- 1) it15) (- 1))
                      (<= (* (- 1) it160) (- 1))
                      (<= (* (- 1) it81) (- 1))
                      (<= (* 2 it120) 0))
  Non linear arithmetic between
    0) it115
    1) it160
    
  Non linear arithmetic between
    0) it115
    1) (exp it160 2)
    
  Non linear arithmetic between
    0) it116
    1) (exp (- 1) it160)
    
  Non linear arithmetic between
    0) it117
    1) (exp (- 1) it160)
    
  Non linear arithmetic between
    0) it160
    1) (exp it115 2)
    
  Non linear arithmetic between
    0) (exp it115 2)
    
  Non linear arithmetic between
    0) (exp it160 2)
    
  Non linear arithmetic between
    0) (exp it160 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
