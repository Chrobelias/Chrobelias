size02.koat_277
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_277.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i3
    1) it92
    
  Non linear arithmetic between
    0) i3
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it117
    1) it1184
    2) it1188
    
  Non linear arithmetic between
    0) it117
    1) it1184
    2) it13
    
  Non linear arithmetic between
    0) it117
    1) it1188
    
  Non linear arithmetic between
    0) it117
    1) it1188
    2) (exp it1184 2)
    
  Non linear arithmetic between
    0) it117
    1) it13
    
  Non linear arithmetic between
    0) it117
    1) it13
    2) (exp it1184 2)
    
  Non linear arithmetic between
    0) it1184
    1) it1188
    2) it13
    3) (exp it117 2)
    
  Non linear arithmetic between
    0) it1184
    1) (exp it117 2)
    2) (exp it1188 2)
    
  Non linear arithmetic between
    0) it1184
    1) (exp it117 2)
    2) (exp it13 2)
    
  Non linear arithmetic between
    0) it1185
    1) (exp (- 1) eee2)
    
  Non linear arithmetic between
    0) it1186
    1) (exp (- 1) eee2)
    
  Non linear arithmetic between
    0) it1188
    1) it13
    2) (exp it117 2)
    
  Non linear arithmetic between
    0) it1188
    1) (exp it117 3)
    2) (exp it13 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it117 3)
    2) (exp it1188 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it1188 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it117 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it1188 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it1184 2)
    
  Non linear arithmetic between
    0) (exp it1188 2)
    
  Non linear arithmetic between
    0) (exp it1188 3)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  Leftover formula:
  (and
                      (= eee1 (+ (* it117 it1188) (* it117 it13)))
                      (= (+ it1183 (* (- 2) it92) (* (- 1) i2)) 1)
                      (= (+ it1184 (* (- 1) i3) (* 2 it92)) 0)
                      (= (+ it1185 (* (- 1) i4 (exp (- 1) it92))) 0)
                      (= (+ it1186 (* (- 1) i5 (exp (- 1) it92))) 0)
                      (= (+ it1203 (* (- 2) it117 it1188) (* (- 2) it117 it13)
                         (* (- 1) it1183)) 0)
                      (= (+ it1204 (* (- 1) it1184) (* 2 it117 it1188)
                         (* 2 it117 it13)) 0)
                      (= (+ it1205 (* (- 1) it1185 (exp (- 1) eee1))) 0)
                      (= (+ it1206 (* (- 1) it1186 (exp (- 1) eee1))) 0)
                      (= (+ (* (- 24) it1188 (exp it117 3) (exp it13 2))
                         (* (- 24) it13 (exp it117 3) (exp it1188 2))
                         (* (- 8) (exp it117 3) (exp it1188 3))
                         (* (- 8) (exp it117 3) (exp it13 3))
                         (* (- 6) it117 it1184 it1188)
                         (* (- 6) it117 it1184 it13)
                         (* (- 6) it117 it1188 (exp it1184 2))
                         (* (- 6) it117 it13 (exp it1184 2)) (* (- 3) it1187)
                         (* (- 1) it117 it1188) (* (- 1) it117 it13)
                         (* 3 it1207) (* 6 (exp it117 2) (exp it1188 2))
                         (* 6 (exp it117 2) (exp it13 2))
                         (* 12 it1184 (exp it117 2) (exp it1188 2))
                         (* 12 it1184 (exp it117 2) (exp it13 2))
                         (* 12 it1188 it13 (exp it117 2))
                         (* 24 it1184 it1188 it13 (exp it117 2))) 0)
                      (= (+ (* (- 8) (exp it92 3)) (* (- 6) i3 it92)
                         (* (- 6) it92 (exp i3 2)) (* (- 3) i6) (* (- 1) it92)
                         (* 3 it1187) (* 6 (exp it92 2))
                         (* 12 i3 (exp it92 2))) 0)
                      (<= 1 it1204)
                      (<= (+ (* (- 2) it1188) (* (- 1) it1184)
                          (* 2 it117 it1188) (* 2 it117 it13)) 0)
                      (<= (+ (* (- 2) it1188) (* (- 1) it1184)
                          (* 2 it117 it1188) (* 2 it117 it13)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 1)
                      (<= (+ (* (- 1) it1184) (* 2 it117 it1188)
                          (* 2 it117 it13)) 0)
                      (<= (+ (* (- 1) it1184) (* 2 it117 it1188)
                          (* 2 it117 it13)) 1)
                      (<= (+ (* (- 1) it1184) (* 2 it1188) (* 2 it13)) 0)
                      (<= (+ (* (- 1) it1184) (* 2 it13)) 0)
                      (<= (* (- 1) it117) (- 1))
                      (<= (* (- 1) it1188) (- 1))
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it92
    
  Non linear arithmetic between
    0) i3
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it117
    1) it1184
    2) it1188
    
  Non linear arithmetic between
    0) it117
    1) it1184
    2) it13
    
  Non linear arithmetic between
    0) it117
    1) it1188
    
  Non linear arithmetic between
    0) it117
    1) it1188
    2) (exp it1184 2)
    
  Non linear arithmetic between
    0) it117
    1) it13
    
  Non linear arithmetic between
    0) it117
    1) it13
    2) (exp it1184 2)
    
  Non linear arithmetic between
    0) it1184
    1) it1188
    2) it13
    3) (exp it117 2)
    
  Non linear arithmetic between
    0) it1184
    1) (exp it117 2)
    2) (exp it1188 2)
    
  Non linear arithmetic between
    0) it1184
    1) (exp it117 2)
    2) (exp it13 2)
    
  Non linear arithmetic between
    0) it1185
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it1186
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it1188
    1) it13
    2) (exp it117 2)
    
  Non linear arithmetic between
    0) it1188
    1) (exp it117 3)
    2) (exp it13 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it117 3)
    2) (exp it1188 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it1188 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it117 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it1188 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it1184 2)
    
  Non linear arithmetic between
    0) (exp it1188 2)
    
  Non linear arithmetic between
    0) (exp it1188 3)
    
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
