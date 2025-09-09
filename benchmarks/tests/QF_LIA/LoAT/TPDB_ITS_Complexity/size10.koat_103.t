size10.koat_103
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_103.smt2 || echo TIMEOUT
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
    0) it15
    1) it290
    
  Non linear arithmetic between
    0) it15
    1) (exp it290 2)
    
  Non linear arithmetic between
    0) it264
    1) it284
    
  Non linear arithmetic between
    0) it284
    1) it285
    
  Non linear arithmetic between
    0) it290
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) it291
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it292
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it120 2)
    
  Non linear arithmetic between
    0) (exp it120 3)
    
  Non linear arithmetic between
    0) (exp it15 2)
    
  Non linear arithmetic between
    0) (exp it15 3)
    
  Non linear arithmetic between
    0) (exp it290 2)
    
  Leftover formula:
  (and
                      (= (+ it185 (* (- 2) it120) (* (- 1) i2)) 1)
                      (= (+ it186 (* (- 1) i3) (* 2 it120)) 0)
                      (= (+ it187 (* (- 1) i4 (exp (- 1) it120))) 0)
                      (= (+ it188 (* (- 1) i5 (exp (- 1) it120))) 0)
                      (= (+ it289 (* (- 4) it284) (* (- 1) it185)
                         (* (- 1) it264 it284) (* (- 1) it284 it285)) 0)
                      (= (+ it290 (* (- 1) i7) (* 2 it284)) 1)
                      (= (+ it291 (* (- 2) i7) (* 4 it284)) 2)
                      (= (+ it292 (* (- 3) i7) (* 6 it284)) 3)
                      (= (+ it293 (* (- 1) i7) (* 2 it284)) 2)
                      (= (+ it294 (* (- 1) i7) (* 2 it284)) 0)
                      (= (+ it362 (* (- 2) it15) (* (- 1) it289)) 0)
                      (= (+ it363 (* (- 1) it290) (* 2 it15)) 0)
                      (= (+ it364 (* (- 1) it291 (exp (- 1) it15))) 0)
                      (= (+ it365 (* (- 1) it292 (exp (- 1) it15))) 0)
                      (= (+ (* (- 8) (exp it120 3)) (* (- 6) i3 it120)
                         (* (- 6) it120 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it120) (* 3 it189) (* 6 (exp it120 2))
                         (* 12 i3 (exp it120 2))) 0)
                      (= (+ (* (- 8) (exp it15 3)) (* (- 6) it15 it290)
                         (* (- 6) it15 (exp it290 2)) (* (- 3) it293)
                         (* (- 1) it15) (* 3 it366) (* 6 (exp it15 2))
                         (* 12 it290 (exp it15 2))) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= (+ (* (- 3) i7) (* 2 it264) (* 6 it284)) 11)
                      (<= (+ (* (- 3) i7) (* 2 it285) (* 6 it284)) 8)
                      (<= (+ (* (- 2) i7) (* (- 1) it186) (* 2 it285)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it120)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it284)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it284)) 1)
                      (<= (+ (* (- 1) it187) (* (- 1) it189) (* 2 it264)) 1)
                      (<= (+ (* (- 1) it290) (* 2 it15)) 0)
                      (<= (+ (* (- 1) it290) (* 2 it15)) 1)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it120) (- 1))
                      (<= (* (- 1) it15) (- 1))
                      (<= (* (- 1) it264) (- 1))
                      (<= (* (- 1) it284) (- 1))
                      (<= (* (- 1) it285) (- 1)))
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
    0) it15
    1) it290
    
  Non linear arithmetic between
    0) it15
    1) (exp it290 2)
    
  Non linear arithmetic between
    0) it264
    1) it284
    
  Non linear arithmetic between
    0) it284
    1) it285
    
  Non linear arithmetic between
    0) it290
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) it291
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) it292
    1) (exp (- 1) it15)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it120 2)
    
  Non linear arithmetic between
    0) (exp it120 3)
    
  Non linear arithmetic between
    0) (exp it15 2)
    
  Non linear arithmetic between
    0) (exp it15 3)
    
  Non linear arithmetic between
    0) (exp it290 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
