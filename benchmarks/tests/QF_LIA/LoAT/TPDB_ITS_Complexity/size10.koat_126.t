size10.koat_126
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_126.smt2 || echo TIMEOUT
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
    
  Leftover formula:
  (and
                      (= (+ i7 (* (- 1) i3) (* 2 it120)) (- 1))
                      (= (+ it391 (* (- 2) it120) (* (- 1) i2)) 1)
                      (= (+ it393 (* (- 1) i4 (exp (- 1) it120))) 0)
                      (= (+ it394 (* (- 1) i5 (exp (- 1) it120))) 0)
                      (= (+ (* (- 8) (exp it120 3)) (* (- 6) i3 it120)
                         (* (- 6) it120 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it120) (* 3 it395) (* 6 (exp it120 2))
                         (* 12 i3 (exp it120 2))) 0)
                      (<= it81 (- 1))
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= (+ (* (- 6) it81) (* (- 3) i7) (* 2 it264)) 11)
                      (<= (+ (* (- 6) it81) (* (- 3) i7) (* 2 it285)) 8)
                      (<= (+ (* (- 3) i7) (* 2 it264)) 5)
                      (<= (+ (* (- 3) i7) (* 2 it285)) 2)
                      (<= (+ (* (- 2) it81) (* (- 1) i7)) (- 2))
                      (<= (+ (* (- 2) it81) (* (- 1) i7)) (- 1))
                      (<= (+ (* (- 2) it81) (* (- 1) i7)) 0)
                      (<= (+ (* (- 2) it81) (* (- 1) i7)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 1)
                      (<= (+ (* (- 1) it393) (* (- 1) it395) (* 2 it264)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) i7) 0)
                      (<= (* (- 1) i7) 1)
                      (<= (* (- 1) it120) (- 1))
                      (<= (* (- 1) it264) (- 1))
                      (<= (* (- 1) it285) (- 1))
                      (<= (* (- 1) it437) (- 1))
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
