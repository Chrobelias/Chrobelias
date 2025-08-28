size01.koat_158
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_158.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (* it13 it73) (* it73 it844)))
                      (= (+ it839 (* (- 2) it48) (* (- 1) i2)) 1)
                      (= (+ it840 (* (- 1) i3) (* 2 it48)) 0)
                      (= (+ it841 (* (- 1) i4 (exp (- 1) it48))) 0)
                      (= (+ it842 (* (- 1) i5 (exp (- 1) it48))) 0)
                      (= (+ it919 (* (- 2) it13 it73) (* (- 2) it73 it844)
                         (* (- 1) it839)) 0)
                      (= (+ it920 (* (- 1) it840) (* 2 it13 it73)
                         (* 2 it73 it844)) 0)
                      (= (+ it921 (* (- 1) it841 (exp (- 1) eee1))) 0)
                      (= (+ it922 (* (- 1) it842 (exp (- 1) eee1))) 0)
                      (= (+ (* (- 24) it13 (exp it73 3) (exp it844 2))
                         (* (- 24) it844 (exp it13 2) (exp it73 3))
                         (* (- 8) (exp it13 3) (exp it73 3))
                         (* (- 8) (exp it73 3) (exp it844 3))
                         (* (- 6) it13 it73 it840)
                         (* (- 6) it13 it73 (exp it840 2))
                         (* (- 6) it73 it840 it844)
                         (* (- 6) it73 it844 (exp it840 2)) (* (- 3) it843)
                         (* (- 1) it13 it73) (* (- 1) it73 it844) (* 3 it923)
                         (* 6 (exp it13 2) (exp it73 2))
                         (* 6 (exp it73 2) (exp it844 2))
                         (* 12 it13 it844 (exp it73 2))
                         (* 12 it840 (exp it13 2) (exp it73 2))
                         (* 12 it840 (exp it73 2) (exp it844 2))
                         (* 24 it13 it840 it844 (exp it73 2))) 0)
                      (= (+ (* (- 8) (exp it48 3)) (* (- 6) i3 it48)
                         (* (- 6) it48 (exp i3 2)) (* (- 3) i6) (* (- 1) it48)
                         (* 3 it843) (* 6 (exp it48 2)) (* 12 i3 (exp it48 2))) 0)
                      (<= 1 it920)
                      (<= (+ (* (- 2) it13) (* (- 2) it844) (* (- 1) it840)
                          (* 2 it13) (* 2 it13 it73) (* 2 it73 it844)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it844) (* (- 1) it840)
                          (* 2 it13) (* 2 it13 it73) (* 2 it73 it844)) 1)
                      (<= (+ (* (- 2) it13) (* (- 2) it844) (* (- 1) it840)
                          (* 2 it13) (* 2 it13 it73) (* 2 it73 it844)
                          (* 2 it844)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it844) (* (- 1) it840)
                          (* 2 it13) (* 2 it13 it73) (* 2 it73 it844)
                          (* 2 it844)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it48)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it48)) 1)
                      (<= (+ (* (- 1) it840) (* 2 it13) (* 2 it844)) 0)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it48) (- 1))
                      (<= (* (- 1) it73) (- 1))
                      (<= (* (- 1) it844) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it48
    
  Non linear arithmetic between
    0) i3
    1) (exp it48 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it48)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it48)
    
  Non linear arithmetic between
    0) it13
    1) it73
    
  Non linear arithmetic between
    0) it13
    1) it73
    2) it840
    
  Non linear arithmetic between
    0) it13
    1) it73
    2) (exp it840 2)
    
  Non linear arithmetic between
    0) it13
    1) it840
    2) it844
    3) (exp it73 2)
    
  Non linear arithmetic between
    0) it13
    1) it844
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it73 3)
    2) (exp it844 2)
    
  Non linear arithmetic between
    0) it48
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) it73
    1) it840
    2) it844
    
  Non linear arithmetic between
    0) it73
    1) it844
    
  Non linear arithmetic between
    0) it73
    1) it844
    2) (exp it840 2)
    
  Non linear arithmetic between
    0) it840
    1) (exp it13 2)
    2) (exp it73 2)
    
  Non linear arithmetic between
    0) it840
    1) (exp it73 2)
    2) (exp it844 2)
    
  Non linear arithmetic between
    0) it841
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it842
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it844
    1) (exp it13 2)
    2) (exp it73 3)
    
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
    0) (exp it48 2)
    
  Non linear arithmetic between
    0) (exp it48 3)
    
  Non linear arithmetic between
    0) (exp it73 2)
    
  Non linear arithmetic between
    0) (exp it73 2)
    1) (exp it844 2)
    
  Non linear arithmetic between
    0) (exp it73 3)
    
  Non linear arithmetic between
    0) (exp it73 3)
    1) (exp it844 3)
    
  Non linear arithmetic between
    0) (exp it840 2)
    
  Non linear arithmetic between
    0) (exp it844 2)
    
  Non linear arithmetic between
    0) (exp it844 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
