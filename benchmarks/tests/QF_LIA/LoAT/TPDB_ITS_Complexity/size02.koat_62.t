size02.koat_62
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_62.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (* it117 it13) (* it117 it92)))
                      (= (+ it121 (* (- 2) it117 it13) (* (- 2) it117 it92)
                         (* (- 1) i2)) 1)
                      (= (+ it122 (* (- 1) i3) (* 2 it117 it13)
                         (* 2 it117 it92)) 0)
                      (= (+ it123 (* (- 1) i4 (exp (- 1) eee1))) 0)
                      (= (+ it124 (* (- 1) i5 (exp (- 1) eee1))) 0)
                      (= (+ it254 (* (- 2) it128) (* (- 1) it121)) 0)
                      (= (+ it255 (* (- 1) it122) (* 2 it128)) 0)
                      (= (+ it256 (* (- 1) it123 (exp (- 1) it128))) 0)
                      (= (+ it257 (* (- 1) it124 (exp (- 1) it128))) 0)
                      (= (+ (* (- 24) it13 (exp it117 3) (exp it92 2))
                         (* (- 24) it92 (exp it117 3) (exp it13 2))
                         (* (- 8) (exp it117 3) (exp it13 3))
                         (* (- 8) (exp it117 3) (exp it92 3))
                         (* (- 6) i3 it117 it13) (* (- 6) i3 it117 it92)
                         (* (- 6) it117 it13 (exp i3 2))
                         (* (- 6) it117 it92 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it117 it13) (* (- 1) it117 it92) (* 3 it125)
                         (* 6 (exp it117 2) (exp it13 2))
                         (* 6 (exp it117 2) (exp it92 2))
                         (* 12 i3 (exp it117 2) (exp it13 2))
                         (* 12 i3 (exp it117 2) (exp it92 2))
                         (* 12 it13 it92 (exp it117 2))
                         (* 24 i3 it13 it92 (exp it117 2))) 0)
                      (= (+ (* (- 8) (exp it128 3)) (* (- 6) it122 it128)
                         (* (- 6) it128 (exp it122 2)) (* (- 3) it125)
                         (* (- 1) it128) (* 3 it258) (* 6 (exp it128 2))
                         (* 12 it122 (exp it128 2))) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it92) (* (- 1) i3)
                          (* 2 it117 it13) (* 2 it117 it92) (* 2 it13)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it92) (* (- 1) i3)
                          (* 2 it117 it13) (* 2 it117 it92) (* 2 it13)) 1)
                      (<= (+ (* (- 2) it13) (* (- 2) it92) (* (- 1) i3)
                          (* 2 it117 it13) (* 2 it117 it92) (* 2 it13)
                          (* 2 it92)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it92) (* (- 1) i3)
                          (* 2 it117 it13) (* 2 it117 it92) (* 2 it13)
                          (* 2 it92)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13) (* 2 it92)) 0)
                      (<= (+ (* (- 1) it122) (* 2 it128)) 0)
                      (<= (+ (* (- 1) it122) (* 2 it128)) 1)
                      (<= (+ (* (- 1) it255) (* 2 it127)) 0)
                      (<= (+ (* (- 1) it255) (* 2 it127)) 1)
                      (<= (* (- 1) it117) (- 1))
                      (<= (* (- 1) it127) (- 1))
                      (<= (* (- 1) it128) (- 1))
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it117
    2) it13
    
  Non linear arithmetic between
    0) i3
    1) it117
    2) it92
    
  Non linear arithmetic between
    0) i3
    1) it13
    2) it92
    3) (exp it117 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it117 2)
    2) (exp it13 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it117 2)
    2) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it117
    1) it13
    
  Non linear arithmetic between
    0) it117
    1) it13
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it117
    1) it92
    
  Non linear arithmetic between
    0) it117
    1) it92
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it122
    1) it128
    
  Non linear arithmetic between
    0) it122
    1) (exp it128 2)
    
  Non linear arithmetic between
    0) it123
    1) (exp (- 1) it128)
    
  Non linear arithmetic between
    0) it124
    1) (exp (- 1) it128)
    
  Non linear arithmetic between
    0) it128
    1) (exp it122 2)
    
  Non linear arithmetic between
    0) it13
    1) it92
    2) (exp it117 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it117 3)
    2) (exp it92 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp it117 3)
    2) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it117 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it92 3)
    
  Non linear arithmetic between
    0) (exp it122 2)
    
  Non linear arithmetic between
    0) (exp it128 2)
    
  Non linear arithmetic between
    0) (exp it128 3)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
