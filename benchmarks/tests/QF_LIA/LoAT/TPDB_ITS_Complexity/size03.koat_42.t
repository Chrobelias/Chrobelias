size03.koat_42
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_42.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (* it127 it152) (* it13 it152)))
                      (= (+ it156 (* (- 2) it127 it152) (* (- 2) it13 it152)
                         (* (- 1) i2)) 1)
                      (= (+ it157 (* (- 1) i3) (* 2 it127 it152)
                         (* 2 it13 it152)) 0)
                      (= (+ it158 (* (- 1) i4 (exp (- 1) eee1))) 0)
                      (= (+ it159 (* (- 1) i5 (exp (- 1) eee1))) 0)
                      (= (+ it212 (* (- 2) it163) (* (- 1) it156)) 0)
                      (= (+ it213 (* (- 1) it157) (* 2 it163)) 0)
                      (= (+ it214 (* (- 1) it158 (exp (- 1) it163))) 0)
                      (= (+ it215 (* (- 1) it159 (exp (- 1) it163))) 0)
                      (= (+ it245 (* (- 2) it162) (* (- 1) it212)) 0)
                      (= (+ it246 (* (- 1) it213) (* 2 it162)) 0)
                      (= (+ it247 (* (- 1) it214 (exp (- 1) it162))) 0)
                      (= (+ it248 (* (- 1) it215 (exp (- 1) it162))) 0)
                      (= (+ (* (- 24) it127 (exp it13 2) (exp it152 3))
                         (* (- 24) it13 (exp it127 2) (exp it152 3))
                         (* (- 8) (exp it127 3) (exp it152 3))
                         (* (- 8) (exp it13 3) (exp it152 3))
                         (* (- 6) i3 it127 it152) (* (- 6) i3 it13 it152)
                         (* (- 6) it127 it152 (exp i3 2))
                         (* (- 6) it13 it152 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it127 it152) (* (- 1) it13 it152) (* 3 it160)
                         (* 6 (exp it127 2) (exp it152 2))
                         (* 6 (exp it13 2) (exp it152 2))
                         (* 12 i3 (exp it127 2) (exp it152 2))
                         (* 12 i3 (exp it13 2) (exp it152 2))
                         (* 12 it127 it13 (exp it152 2))
                         (* 24 i3 it127 it13 (exp it152 2))) 0)
                      (= (+ (* (- 8) (exp it162 3)) (* (- 6) it162 it213)
                         (* (- 6) it162 (exp it213 2)) (* (- 3) it216)
                         (* (- 1) it162) (* 3 it249) (* 6 (exp it162 2))
                         (* 12 it213 (exp it162 2))) 0)
                      (= (+ (* (- 8) (exp it163 3)) (* (- 6) it157 it163)
                         (* (- 6) it163 (exp it157 2)) (* (- 3) it160)
                         (* (- 1) it163) (* 3 it216) (* 6 (exp it163 2))
                         (* 12 it157 (exp it163 2))) 0)
                      (= (+ (* 2 it217) (* 2 it250)) 0)
                      (<= (+ (* (- 2) it127) (* (- 2) it13) (* (- 1) i3)
                          (* 2 it127) (* 2 it127 it152) (* 2 it13)
                          (* 2 it13 it152)) 0)
                      (<= (+ (* (- 2) it127) (* (- 2) it13) (* (- 1) i3)
                          (* 2 it127) (* 2 it127 it152) (* 2 it13)
                          (* 2 it13 it152)) 1)
                      (<= (+ (* (- 2) it127) (* (- 2) it13) (* (- 1) i3)
                          (* 2 it127 it152) (* 2 it13) (* 2 it13 it152)) 0)
                      (<= (+ (* (- 2) it127) (* (- 2) it13) (* (- 1) i3)
                          (* 2 it127 it152) (* 2 it13) (* 2 it13 it152)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) it157) (* 2 it163)) 0)
                      (<= (+ (* (- 1) it157) (* 2 it163)) 1)
                      (<= (+ (* (- 1) it213) (* 2 it162)) 0)
                      (<= (+ (* (- 1) it213) (* 2 it162)) 1)
                      (<= (+ (* (- 1) it246) (* 2 it217)) 0)
                      (<= (+ (* (- 1) it246) (* 2 it217)) 1)
                      (<= (+ (* (- 1) it246) (* 2 it217) (* 2 it250)) 0)
                      (<= (+ (* (- 1) it246) (* 2 it217) (* 2 it250)) 1)
                      (<= (+ (* 2 it217) (* 2 it250)) 0)
                      (<= (* (- 1) it127) (- 1))
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it152) (- 1))
                      (<= (* (- 1) it162) (- 1))
                      (<= (* (- 1) it163) (- 1))
                      (<= (* (- 1) it217) (- 1))
                      (<= (* (- 1) it250) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it127
    2) it13
    3) (exp it152 2)
    
  Non linear arithmetic between
    0) i3
    1) it127
    2) it152
    
  Non linear arithmetic between
    0) i3
    1) it13
    2) it152
    
  Non linear arithmetic between
    0) i3
    1) (exp it127 2)
    2) (exp it152 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    2) (exp it152 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it127
    1) it13
    2) (exp it152 2)
    
  Non linear arithmetic between
    0) it127
    1) it152
    
  Non linear arithmetic between
    0) it127
    1) it152
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it127
    1) (exp it13 2)
    2) (exp it152 3)
    
  Non linear arithmetic between
    0) it13
    1) it152
    
  Non linear arithmetic between
    0) it13
    1) it152
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it127 2)
    2) (exp it152 3)
    
  Non linear arithmetic between
    0) it157
    1) it163
    
  Non linear arithmetic between
    0) it157
    1) (exp it163 2)
    
  Non linear arithmetic between
    0) it158
    1) (exp (- 1) it163)
    
  Non linear arithmetic between
    0) it159
    1) (exp (- 1) it163)
    
  Non linear arithmetic between
    0) it162
    1) it213
    
  Non linear arithmetic between
    0) it162
    1) (exp it213 2)
    
  Non linear arithmetic between
    0) it163
    1) (exp it157 2)
    
  Non linear arithmetic between
    0) it213
    1) (exp it162 2)
    
  Non linear arithmetic between
    0) it214
    1) (exp (- 1) it162)
    
  Non linear arithmetic between
    0) it215
    1) (exp (- 1) it162)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it127 2)
    
  Non linear arithmetic between
    0) (exp it127 2)
    1) (exp it152 2)
    
  Non linear arithmetic between
    0) (exp it127 3)
    
  Non linear arithmetic between
    0) (exp it127 3)
    1) (exp it152 3)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    1) (exp it152 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it13 3)
    1) (exp it152 3)
    
  Non linear arithmetic between
    0) (exp it152 2)
    
  Non linear arithmetic between
    0) (exp it152 3)
    
  Non linear arithmetic between
    0) (exp it157 2)
    
  Non linear arithmetic between
    0) (exp it162 2)
    
  Non linear arithmetic between
    0) (exp it162 3)
    
  Non linear arithmetic between
    0) (exp it163 2)
    
  Non linear arithmetic between
    0) (exp it163 3)
    
  Non linear arithmetic between
    0) (exp it213 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
