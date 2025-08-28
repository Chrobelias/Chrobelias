size10.koat_138
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_138.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= (+ it391 (* (- 2) it120) (* (- 1) i2)) 1)
                      (= (+ it392 (* (- 1) i3) (* 2 it120)) 0)
                      (= (+ it393 (* (- 1) i4 (exp (- 1) it120))) 0)
                      (= (+ it394 (* (- 1) i5 (exp (- 1) it120))) 0)
                      (= (+ it443 (* (- 4) it284) (* (- 1) it264 it284)
                         (* (- 1) it284 it285) (* (- 1) it391)) 0)
                      (= (+ it444 (* (- 1) i7) (* 2 it284)) 1)
                      (= (+ it445 (* (- 2) i7) (* 4 it284)) 2)
                      (= (+ it446 (* (- 3) i7) (* 6 it284)) 3)
                      (= (+ it447 (* (- 1) i7) (* 2 it284)) 2)
                      (= (+ it448 (* (- 1) i7) (* 2 it284)) 0)
                      (= (+ it455 (* (- 2) it397) (* (- 1) it443)) 0)
                      (= (+ it456 (* (- 1) it444) (* 2 it397)) 0)
                      (= (+ it456 (* (- 1) it448) (* 2 it450) (* 2 it81)) 1)
                      (= (+ it457 (* (- 2) it448) (* 4 it450) (* 4 it81)) 2)
                      (= (+ it457 (* (- 1) it445 (exp (- 1) it397))) 0)
                      (= (+ it458 (* (- 1) it446 (exp (- 1) it397))) 0)
                      (= (+ it459 (* (- 1) it448) (* 2 it450) (* 2 it81)) 2)
                      (= (+ (* (- 8) (exp it120 3)) (* (- 6) i3 it120)
                         (* (- 6) it120 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it120) (* 3 it395) (* 6 (exp it120 2))
                         (* 12 i3 (exp it120 2))) 0)
                      (= (+ (* (- 8) (exp it397 3)) (* (- 6) it397 it444)
                         (* (- 6) it397 (exp it444 2)) (* (- 3) it447)
                         (* (- 1) it397) (* 3 it459) (* 6 (exp it397 2))
                         (* 12 it444 (exp it397 2))) 0)
                      (= (+ (* 2 it450) (* 2 it81)) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it448)
                      (<= (+ (* (- 3) i7) (* 2 it264) (* 6 it284)) 11)
                      (<= (+ (* (- 3) i7) (* 2 it285) (* 6 it284)) 8)
                      (<= (+ (* (- 3) it448) (* 2 it449) (* 6 it450)) 8)
                      (<= (+ (* (- 3) it448) (* 2 it451) (* 6 it450)) 11)
                      (<= (+ (* (- 2) i7) (* (- 1) it392) (* 2 it285)) 1)
                      (<= (+ (* (- 2) it448) (* (- 1) it456) (* 2 it449)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it284)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it284)) 1)
                      (<= (+ (* (- 1) it393) (* (- 1) it395) (* 2 it264)) 1)
                      (<= (+ (* (- 1) it444) (* 2 it397)) 0)
                      (<= (+ (* (- 1) it444) (* 2 it397)) 1)
                      (<= (+ (* (- 1) it448) (* 2 it450)) (- 2))
                      (<= (+ (* (- 1) it448) (* 2 it450)) (- 1))
                      (<= (+ (* (- 1) it448) (* 2 it450)) 0)
                      (<= (+ (* (- 1) it448) (* 2 it450)) 1)
                      (<= (+ (* (- 1) it448) (* 2 it450) (* 2 it81)) 0)
                      (<= (+ (* (- 1) it448) (* 2 it450) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it457) (* (- 1) it459) (* 2 it451)) 1)
                      (<= (+ (* 2 it450) (* 2 it81)) 0)
                      (<= (+ (* 6 it450) (* 6 it81)) 0)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it120) (- 1))
                      (<= (* (- 1) it264) (- 1))
                      (<= (* (- 1) it284) (- 1))
                      (<= (* (- 1) it285) (- 1))
                      (<= (* (- 1) it397) (- 1))
                      (<= (* (- 1) it448) (- 2))
                      (<= (* (- 1) it449) (- 1))
                      (<= (* (- 1) it450) (- 1))
                      (<= (* (- 1) it451) (- 1))
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
    0) it264
    1) it284
    
  Non linear arithmetic between
    0) it284
    1) it285
    
  Non linear arithmetic between
    0) it397
    1) it444
    
  Non linear arithmetic between
    0) it397
    1) (exp it444 2)
    
  Non linear arithmetic between
    0) it444
    1) (exp it397 2)
    
  Non linear arithmetic between
    0) it445
    1) (exp (- 1) it397)
    
  Non linear arithmetic between
    0) it446
    1) (exp (- 1) it397)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it120 2)
    
  Non linear arithmetic between
    0) (exp it120 3)
    
  Non linear arithmetic between
    0) (exp it397 2)
    
  Non linear arithmetic between
    0) (exp it397 3)
    
  Non linear arithmetic between
    0) (exp it444 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
