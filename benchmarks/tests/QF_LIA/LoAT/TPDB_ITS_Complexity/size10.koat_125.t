size10.koat_125
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_125.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it391 (* (- 2) it120) (* (- 1) i2)) 1)
                      (= (+ it392 (* (- 1) i3) (* 2 it120)) 0)
                      (= (+ it392 (* (- 1) i7) (* 2 it284) (* 2 it81)) 1)
                      (= (+ it393 (* (- 2) i7) (* 4 it284) (* 4 it81)) 2)
                      (= (+ it393 (* (- 1) i4 (exp (- 1) it120))) 0)
                      (= (+ it394 (* (- 1) i5 (exp (- 1) it120))) 0)
                      (= (+ it395 (* (- 1) i7) (* 2 it284) (* 2 it81)) 2)
                      (= (+ (* (- 8) (exp it120 3)) (* (- 6) i3 it120)
                         (* (- 6) it120 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it120) (* 3 it395) (* 6 (exp it120 2))
                         (* 12 i3 (exp it120 2))) 0)
                      (= (+ (* 2 it284) (* 2 it81)) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= (+ (* (- 3) i7) (* 2 it264) (* 6 it284)) 11)
                      (<= (+ (* (- 3) i7) (* 2 it285) (* 6 it284)) 8)
                      (<= (+ (* (- 2) i7) (* (- 1) it392) (* 2 it285)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it284)) (- 2))
                      (<= (+ (* (- 1) i7) (* 2 it284)) (- 1))
                      (<= (+ (* (- 1) i7) (* 2 it284)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it284)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it284) (* 2 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it284) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it393) (* (- 1) it395) (* 2 it264)) 1)
                      (<= (+ (* 2 it284) (* 2 it81)) 0)
                      (<= (+ (* 6 it284) (* 6 it81)) 0)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it120) (- 1))
                      (<= (* (- 1) it264) (- 1))
                      (<= (* (- 1) it284) (- 1))
                      (<= (* (- 1) it285) (- 1))
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
