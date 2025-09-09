size01.koat_101
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_101.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i3
    1) it13
    2) it436
    
  Non linear arithmetic between
    0) i3
    1) it13
    2) it48
    3) (exp it436 2)
    
  Non linear arithmetic between
    0) i3
    1) it436
    2) it48
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    2) (exp it436 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it436 2)
    2) (exp it48 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) eee3)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) eee3)
    
  Non linear arithmetic between
    0) it13
    1) it436
    
  Non linear arithmetic between
    0) it13
    1) it436
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it13
    1) it48
    2) (exp it436 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it436 3)
    2) (exp it48 2)
    
  Non linear arithmetic between
    0) it436
    1) it48
    
  Non linear arithmetic between
    0) it436
    1) it48
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it441
    1) it446
    
  Non linear arithmetic between
    0) it441
    1) (exp it446 2)
    
  Non linear arithmetic between
    0) it442
    1) (exp (- 1) it446)
    
  Non linear arithmetic between
    0) it443
    1) (exp (- 1) it446)
    
  Non linear arithmetic between
    0) it446
    1) (exp it441 2)
    
  Non linear arithmetic between
    0) it447
    1) it497
    2) it501
    3) (exp it73 2)
    
  Non linear arithmetic between
    0) it447
    1) it497
    2) it73
    
  Non linear arithmetic between
    0) it447
    1) it501
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it447
    1) it73
    
  Non linear arithmetic between
    0) it447
    1) it73
    2) (exp it497 2)
    
  Non linear arithmetic between
    0) it447
    1) (exp it501 2)
    2) (exp it73 3)
    
  Non linear arithmetic between
    0) it48
    1) (exp it13 2)
    2) (exp it436 3)
    
  Non linear arithmetic between
    0) it497
    1) it501
    2) it73
    
  Non linear arithmetic between
    0) it497
    1) (exp it447 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it497
    1) (exp it501 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it498
    1) (exp (- 1) eee4)
    
  Non linear arithmetic between
    0) it499
    1) (exp (- 1) eee4)
    
  Non linear arithmetic between
    0) it501
    1) it73
    
  Non linear arithmetic between
    0) it501
    1) it73
    2) (exp it497 2)
    
  Non linear arithmetic between
    0) it501
    1) (exp it447 2)
    2) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    1) (exp it436 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it13 3)
    1) (exp it436 3)
    
  Non linear arithmetic between
    0) (exp it436 2)
    
  Non linear arithmetic between
    0) (exp it436 2)
    1) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it436 3)
    
  Non linear arithmetic between
    0) (exp it436 3)
    1) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp it441 2)
    
  Non linear arithmetic between
    0) (exp it446 2)
    
  Non linear arithmetic between
    0) (exp it446 3)
    
  Non linear arithmetic between
    0) (exp it447 2)
    
  Non linear arithmetic between
    0) (exp it447 2)
    1) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it447 3)
    
  Non linear arithmetic between
    0) (exp it447 3)
    1) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp it497 2)
    
  Non linear arithmetic between
    0) (exp it501 2)
    
  Non linear arithmetic between
    0) (exp it501 2)
    1) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it501 3)
    
  Non linear arithmetic between
    0) (exp it501 3)
    1) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it73 3)
    
  Leftover formula:
  (and
                      (= eee2 (+ (* it447 it73) (* it501 it73)))
                      (= eee1 (+ (* it13 it436) (* it436 it48)))
                      (= (+ it440 (* (- 2) it13 it436) (* (- 2) it436 it48)
                         (* (- 1) i2)) 1)
                      (= (+ it441 (* (- 1) i3) (* 2 it13 it436)
                         (* 2 it436 it48)) 0)
                      (= (+ it442 (* (- 1) i4 (exp (- 1) eee1))) 0)
                      (= (+ it443 (* (- 1) i5 (exp (- 1) eee1))) 0)
                      (= (+ it496 (* (- 2) it446) (* (- 1) it440)) 0)
                      (= (+ it497 (* (- 1) it441) (* 2 it446)) 0)
                      (= (+ it498 (* (- 1) it442 (exp (- 1) it446))) 0)
                      (= (+ it499 (* (- 1) it443 (exp (- 1) it446))) 0)
                      (= (+ it596 (* (- 2) it447 it73) (* (- 2) it501 it73)
                         (* (- 1) it496)) 0)
                      (= (+ it597 (* (- 1) it497) (* 2 it447 it73)
                         (* 2 it501 it73)) 0)
                      (= (+ it598 (* (- 1) it498 (exp (- 1) eee2))) 0)
                      (= (+ it599 (* (- 1) it499 (exp (- 1) eee2))) 0)
                      (= (+ (* (- 24) it13 (exp it436 3) (exp it48 2))
                         (* (- 24) it48 (exp it13 2) (exp it436 3))
                         (* (- 8) (exp it13 3) (exp it436 3))
                         (* (- 8) (exp it436 3) (exp it48 3))
                         (* (- 6) i3 it13 it436) (* (- 6) i3 it436 it48)
                         (* (- 6) it13 it436 (exp i3 2))
                         (* (- 6) it436 it48 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it13 it436) (* (- 1) it436 it48) (* 3 it444)
                         (* 6 (exp it13 2) (exp it436 2))
                         (* 6 (exp it436 2) (exp it48 2))
                         (* 12 i3 (exp it13 2) (exp it436 2))
                         (* 12 i3 (exp it436 2) (exp it48 2))
                         (* 12 it13 it48 (exp it436 2))
                         (* 24 i3 it13 it48 (exp it436 2))) 0)
                      (= (+ (* (- 24) it447 (exp it501 2) (exp it73 3))
                         (* (- 24) it501 (exp it447 2) (exp it73 3))
                         (* (- 8) (exp it447 3) (exp it73 3))
                         (* (- 8) (exp it501 3) (exp it73 3))
                         (* (- 6) it447 it497 it73)
                         (* (- 6) it447 it73 (exp it497 2))
                         (* (- 6) it497 it501 it73)
                         (* (- 6) it501 it73 (exp it497 2)) (* (- 3) it500)
                         (* (- 1) it447 it73) (* (- 1) it501 it73) (* 3 it600)
                         (* 6 (exp it447 2) (exp it73 2))
                         (* 6 (exp it501 2) (exp it73 2))
                         (* 12 it447 it501 (exp it73 2))
                         (* 12 it497 (exp it447 2) (exp it73 2))
                         (* 12 it497 (exp it501 2) (exp it73 2))
                         (* 24 it447 it497 it501 (exp it73 2))) 0)
                      (= (+ (* (- 8) (exp it446 3)) (* (- 6) it441 it446)
                         (* (- 6) it446 (exp it441 2)) (* (- 3) it444)
                         (* (- 1) it446) (* 3 it500) (* 6 (exp it446 2))
                         (* 12 it441 (exp it446 2))) 0)
                      (<= (+ (* (- 2) it13) (* (- 1) i3) (* 2 it13 it436)
                          (* 2 it436 it48)) 0)
                      (<= (+ (* (- 2) it13) (* (- 1) i3) (* 2 it13 it436)
                          (* 2 it436 it48)) 1)
                      (<= (+ (* (- 2) it501) (* (- 1) it497) (* 2 it447 it73)
                          (* 2 it501 it73)) 0)
                      (<= (+ (* (- 2) it501) (* (- 1) it497) (* 2 it447 it73)
                          (* 2 it501 it73)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it13) (* 2 it48)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13 it436) (* 2 it436 it48)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13 it436) (* 2 it436 it48)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it48)) 0)
                      (<= (+ (* (- 1) it441) (* 2 it446)) 0)
                      (<= (+ (* (- 1) it441) (* 2 it446)) 1)
                      (<= (+ (* (- 1) it497) (* 2 it447) (* 2 it501)) 0)
                      (<= (+ (* (- 1) it497) (* 2 it447 it73) (* 2 it501 it73)) 0)
                      (<= (+ (* (- 1) it497) (* 2 it447 it73) (* 2 it501 it73)) 1)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it436) (- 1))
                      (<= (* (- 1) it446) (- 1))
                      (<= (* (- 1) it447) (- 1))
                      (<= (* (- 1) it48) (- 1))
                      (<= (* (- 1) it501) (- 1))
                      (<= (* (- 1) it73) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it13
    2) it436
    
  Non linear arithmetic between
    0) i3
    1) it13
    2) it48
    3) (exp it436 2)
    
  Non linear arithmetic between
    0) i3
    1) it436
    2) it48
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    2) (exp it436 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it436 2)
    2) (exp it48 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it13
    1) it436
    
  Non linear arithmetic between
    0) it13
    1) it436
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it13
    1) it48
    2) (exp it436 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it436 3)
    2) (exp it48 2)
    
  Non linear arithmetic between
    0) it436
    1) it48
    
  Non linear arithmetic between
    0) it436
    1) it48
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it441
    1) it446
    
  Non linear arithmetic between
    0) it441
    1) (exp it446 2)
    
  Non linear arithmetic between
    0) it442
    1) (exp (- 1) it446)
    
  Non linear arithmetic between
    0) it443
    1) (exp (- 1) it446)
    
  Non linear arithmetic between
    0) it446
    1) (exp it441 2)
    
  Non linear arithmetic between
    0) it447
    1) it497
    2) it501
    3) (exp it73 2)
    
  Non linear arithmetic between
    0) it447
    1) it497
    2) it73
    
  Non linear arithmetic between
    0) it447
    1) it501
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it447
    1) it73
    
  Non linear arithmetic between
    0) it447
    1) it73
    2) (exp it497 2)
    
  Non linear arithmetic between
    0) it447
    1) (exp it501 2)
    2) (exp it73 3)
    
  Non linear arithmetic between
    0) it48
    1) (exp it13 2)
    2) (exp it436 3)
    
  Non linear arithmetic between
    0) it497
    1) it501
    2) it73
    
  Non linear arithmetic between
    0) it497
    1) (exp it447 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it497
    1) (exp it501 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it498
    1) (exp (- 1) eee2)
    
  Non linear arithmetic between
    0) it499
    1) (exp (- 1) eee2)
    
  Non linear arithmetic between
    0) it501
    1) it73
    
  Non linear arithmetic between
    0) it501
    1) it73
    2) (exp it497 2)
    
  Non linear arithmetic between
    0) it501
    1) (exp it447 2)
    2) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    1) (exp it436 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it13 3)
    1) (exp it436 3)
    
  Non linear arithmetic between
    0) (exp it436 2)
    
  Non linear arithmetic between
    0) (exp it436 2)
    1) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it436 3)
    
  Non linear arithmetic between
    0) (exp it436 3)
    1) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp it441 2)
    
  Non linear arithmetic between
    0) (exp it446 2)
    
  Non linear arithmetic between
    0) (exp it446 3)
    
  Non linear arithmetic between
    0) (exp it447 2)
    
  Non linear arithmetic between
    0) (exp it447 2)
    1) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it447 3)
    
  Non linear arithmetic between
    0) (exp it447 3)
    1) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp it497 2)
    
  Non linear arithmetic between
    0) (exp it501 2)
    
  Non linear arithmetic between
    0) (exp it501 2)
    1) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it501 3)
    
  Non linear arithmetic between
    0) (exp it501 3)
    1) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it73 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
