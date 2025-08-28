size10.koat_19
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_19.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it122 (* (- 2) it120) (* (- 1) i2)) 1)
                      (= (+ it123 (* (- 1) i3) (* 2 it120)) 0)
                      (= (+ it124 (* (- 1) i4 (exp (- 1) it120))) 0)
                      (= (+ it125 (* (- 1) i5 (exp (- 1) it120))) 0)
                      (= (+ (* (- 8) (exp it120 3)) (* (- 6) i3 it120)
                         (* (- 6) it120 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it120) (* 3 it126) (* 6 (exp it120 2))
                         (* 12 i3 (exp it120 2))) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it120) (- 1))
                      (<= (* (- 1) it81) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it120
    
  Non linear arithmetic between
    0) i3
    1) (exp it120 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it120)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it120)
    
  Non linear arithmetic between
    0) it120
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it120 2)
    
  Non linear arithmetic between
    0) (exp it120 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
