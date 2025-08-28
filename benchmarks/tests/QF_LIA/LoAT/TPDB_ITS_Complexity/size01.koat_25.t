size01.koat_25
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_25.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (* it13 it73) (* it48 it73)))
                      (= (+ it133 (* (- 2) it84) (* (- 1) it77)) 0)
                      (= (+ it134 (* (- 1) it78) (* 2 it84)) 0)
                      (= (+ it135 (* (- 1) it79 (exp (- 1) it84))) 0)
                      (= (+ it136 (* (- 1) it80 (exp (- 1) it84))) 0)
                      (= (+ it166 (* (- 2) it83) (* (- 1) it133)) 0)
                      (= (+ it167 (* (- 1) it134) (* 2 it83)) 0)
                      (= (+ it168 (* (- 1) it135 (exp (- 1) it83))) 0)
                      (= (+ it169 (* (- 1) it136 (exp (- 1) it83))) 0)
                      (= (+ it77 (* (- 2) it13 it73) (* (- 2) it48 it73)
                         (* (- 1) i2)) 1)
                      (= (+ it78 (* (- 1) i3) (* 2 it13 it73) (* 2 it48 it73)) 0)
                      (= (+ it79 (* (- 1) i4 (exp (- 1) eee1))) 0)
                      (= (+ it80 (* (- 1) i5 (exp (- 1) eee1))) 0)
                      (= (+ (* (- 24) it13 (exp it48 2) (exp it73 3))
                         (* (- 24) it48 (exp it13 2) (exp it73 3))
                         (* (- 8) (exp it13 3) (exp it73 3))
                         (* (- 8) (exp it48 3) (exp it73 3))
                         (* (- 6) i3 it13 it73) (* (- 6) i3 it48 it73)
                         (* (- 6) it13 it73 (exp i3 2))
                         (* (- 6) it48 it73 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it13 it73) (* (- 1) it48 it73) (* 3 it81)
                         (* 6 (exp it13 2) (exp it73 2))
                         (* 6 (exp it48 2) (exp it73 2))
                         (* 12 i3 (exp it13 2) (exp it73 2))
                         (* 12 i3 (exp it48 2) (exp it73 2))
                         (* 12 it13 it48 (exp it73 2))
                         (* 24 i3 it13 it48 (exp it73 2))) 0)
                      (= (+ (* (- 8) (exp it83 3)) (* (- 6) it134 it83)
                         (* (- 6) it83 (exp it134 2)) (* (- 3) it137)
                         (* (- 1) it83) (* 3 it170) (* 6 (exp it83 2))
                         (* 12 it134 (exp it83 2))) 0)
                      (= (+ (* (- 8) (exp it84 3)) (* (- 6) it78 it84)
                         (* (- 6) it84 (exp it78 2)) (* (- 3) it81)
                         (* (- 1) it84) (* 3 it137) (* 6 (exp it84 2))
                         (* 12 it78 (exp it84 2))) 0)
                      (= (+ (* 2 it138) (* 2 it171)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it73) (* 2 it48)
                          (* 2 it48 it73)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it73) (* 2 it48)
                          (* 2 it48 it73)) 1)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it73) (* 2 it48 it73)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it48) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it73) (* 2 it48 it73)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it13) (* 2 it48)) 0)
                      (<= (+ (* (- 1) it134) (* 2 it83)) 0)
                      (<= (+ (* (- 1) it134) (* 2 it83)) 1)
                      (<= (+ (* (- 1) it167) (* 2 it138)) 0)
                      (<= (+ (* (- 1) it167) (* 2 it138)) 1)
                      (<= (+ (* (- 1) it167) (* 2 it138) (* 2 it171)) 0)
                      (<= (+ (* (- 1) it167) (* 2 it138) (* 2 it171)) 1)
                      (<= (+ (* (- 1) it78) (* 2 it84)) 0)
                      (<= (+ (* (- 1) it78) (* 2 it84)) 1)
                      (<= (+ (* 2 it138) (* 2 it171)) 0)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it138) (- 1))
                      (<= (* (- 1) it171) (- 1))
                      (<= (* (- 1) it48) (- 1))
                      (<= (* (- 1) it73) (- 1))
                      (<= (* (- 1) it83) (- 1))
                      (<= (* (- 1) it84) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it13
    2) it48
    3) (exp it73 2)
    
  Non linear arithmetic between
    0) i3
    1) it13
    2) it73
    
  Non linear arithmetic between
    0) i3
    1) it48
    2) it73
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it48 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it13
    1) it48
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it13
    1) it73
    
  Non linear arithmetic between
    0) it13
    1) it73
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it48 2)
    2) (exp it73 3)
    
  Non linear arithmetic between
    0) it134
    1) it83
    
  Non linear arithmetic between
    0) it134
    1) (exp it83 2)
    
  Non linear arithmetic between
    0) it135
    1) (exp (- 1) it83)
    
  Non linear arithmetic between
    0) it136
    1) (exp (- 1) it83)
    
  Non linear arithmetic between
    0) it48
    1) it73
    
  Non linear arithmetic between
    0) it48
    1) it73
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it48
    1) (exp it13 2)
    2) (exp it73 3)
    
  Non linear arithmetic between
    0) it78
    1) it84
    
  Non linear arithmetic between
    0) it78
    1) (exp it84 2)
    
  Non linear arithmetic between
    0) it79
    1) (exp (- 1) it84)
    
  Non linear arithmetic between
    0) it80
    1) (exp (- 1) it84)
    
  Non linear arithmetic between
    0) it83
    1) (exp it134 2)
    
  Non linear arithmetic between
    0) it84
    1) (exp it78 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    1) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it13 3)
    1) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it134 2)
    
  Non linear arithmetic between
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 2)
    1) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp it48 3)
    1) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it78 2)
    
  Non linear arithmetic between
    0) (exp it83 2)
    
  Non linear arithmetic between
    0) (exp it83 3)
    
  Non linear arithmetic between
    0) (exp it84 2)
    
  Non linear arithmetic between
    0) (exp it84 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
