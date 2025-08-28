size10.koat_20
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_20.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it122 (* (- 2) it120) (* (- 1) i2)) 1)
                      (= (+ it123 (* (- 1) i3) (* 2 it120)) 0)
                      (= (+ it124 (* (- 1) i4 (exp (- 1) it120))) 0)
                      (= (+ it125 (* (- 1) i5 (exp (- 1) it120))) 0)
                      (= (+ it147 (* (- 4) it81) (* (- 1) it122)) 0)
                      (= (+ it148 (* (- 1) i7) (* 2 it81)) 1)
                      (= (+ it148 (* (- 1) it152) (* 2 it153)) 1)
                      (= (+ it149 (* (- 2) i7) (* 4 it81)) 2)
                      (= (+ it150 (* (- 3) i7) (* 6 it81)) 3)
                      (= (+ it151 (* (- 1) i7) (* 2 it81)) 2)
                      (= (+ it152 (* (- 1) i7) (* 2 it81)) 0)
                      (= (+ (* (- 8) (exp it120 3)) (* (- 6) i3 it120)
                         (* (- 6) it120 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it120) (* 3 it126) (* 6 (exp it120 2))
                         (* 12 i3 (exp it120 2))) 0)
                      (= (* 2 it153) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it152)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it148) (* 2 it15)) 0)
                      (<= (+ (* (- 1) it148) (* 2 it15)) 1)
                      (<= (+ (* (- 1) it152) (* 2 it153)) 0)
                      (<= (+ (* (- 1) it152) (* 2 it153)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it120) (- 1))
                      (<= (* (- 1) it15) (- 1))
                      (<= (* (- 1) it152) (- 2))
                      (<= (* (- 1) it153) (- 1))
                      (<= (* (- 1) it81) (- 1))
                      (<= (* 2 it153) 0))
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
