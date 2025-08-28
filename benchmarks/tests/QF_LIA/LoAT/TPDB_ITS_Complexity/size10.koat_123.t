size10.koat_123
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_123.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it391 (* (- 2) it120) (* (- 1) i2)) 1)
                      (= (+ it392 (* (- 1) i3) (* 2 it120)) 0)
                      (= (+ it393 (* (- 1) i4 (exp (- 1) it120))) 0)
                      (= (+ it394 (* (- 1) i5 (exp (- 1) it120))) 0)
                      (= (+ it416 (* (- 4) it284) (* (- 1) it264 it284)
                         (* (- 1) it284 it285) (* (- 1) it391)) 0)
                      (= (+ it417 (* (- 1) i7) (* 2 it284)) 1)
                      (= (+ it418 (* (- 2) i7) (* 4 it284)) 2)
                      (= (+ it419 (* (- 3) i7) (* 6 it284)) 3)
                      (= (+ it420 (* (- 1) i7) (* 2 it284)) 2)
                      (= (+ it421 (* (- 1) i7) (* 2 it284)) 0)
                      (= (+ it428 (* (- 4) it81) (* (- 1) it416)) 0)
                      (= (+ it429 (* (- 1) it421) (* 2 it81)) 1)
                      (= (+ it429 (* (- 1) it433) (* 2 it434)) 1)
                      (= (+ it430 (* (- 2) it421) (* 4 it81)) 2)
                      (= (+ it431 (* (- 3) it421) (* 6 it81)) 3)
                      (= (+ it432 (* (- 1) it421) (* 2 it81)) 2)
                      (= (+ it433 (* (- 1) it421) (* 2 it81)) 0)
                      (= (+ (* (- 8) (exp it120 3)) (* (- 6) i3 it120)
                         (* (- 6) it120 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it120) (* 3 it395) (* 6 (exp it120 2))
                         (* 12 i3 (exp it120 2))) 0)
                      (= (* 2 it434) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it421)
                      (<= 1 it433)
                      (<= (+ (* (- 3) i7) (* 2 it264) (* 6 it284)) 11)
                      (<= (+ (* (- 3) i7) (* 2 it285) (* 6 it284)) 8)
                      (<= (+ (* (- 2) i7) (* (- 1) it392) (* 2 it285)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it284)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it284)) 1)
                      (<= (+ (* (- 1) it393) (* (- 1) it395) (* 2 it264)) 1)
                      (<= (+ (* (- 1) it421) (* 2 it81)) 0)
                      (<= (+ (* (- 1) it421) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it429) (* 2 it397)) 0)
                      (<= (+ (* (- 1) it429) (* 2 it397)) 1)
                      (<= (+ (* (- 1) it433) (* 2 it434)) 0)
                      (<= (+ (* (- 1) it433) (* 2 it434)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it120) (- 1))
                      (<= (* (- 1) it264) (- 1))
                      (<= (* (- 1) it284) (- 1))
                      (<= (* (- 1) it285) (- 1))
                      (<= (* (- 1) it397) (- 1))
                      (<= (* (- 1) it421) (- 2))
                      (<= (* (- 1) it433) (- 2))
                      (<= (* (- 1) it434) (- 1))
                      (<= (* (- 1) it81) (- 1))
                      (<= (* 2 it434) 0))
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
    0) it264
    1) it284
    
  Non linear arithmetic between
    0) it284
    1) it285
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it120 2)
    
  Non linear arithmetic between
    0) (exp it120 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
