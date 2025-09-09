size02.koat_209
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_209.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) i3
    1) it13
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) it488
    1) it868
    2) it872
    
  Non linear arithmetic between
    0) it488
    1) it868
    2) it92
    
  Non linear arithmetic between
    0) it488
    1) it872
    
  Non linear arithmetic between
    0) it488
    1) it872
    2) (exp it868 2)
    
  Non linear arithmetic between
    0) it488
    1) it92
    
  Non linear arithmetic between
    0) it488
    1) it92
    2) (exp it868 2)
    
  Non linear arithmetic between
    0) it868
    1) it872
    2) it92
    3) (exp it488 2)
    
  Non linear arithmetic between
    0) it868
    1) (exp it488 2)
    2) (exp it872 2)
    
  Non linear arithmetic between
    0) it868
    1) (exp it488 2)
    2) (exp it92 2)
    
  Non linear arithmetic between
    0) it869
    1) (exp (- 1) eee2)
    
  Non linear arithmetic between
    0) it870
    1) (exp (- 1) eee2)
    
  Non linear arithmetic between
    0) it872
    1) it92
    2) (exp it488 2)
    
  Non linear arithmetic between
    0) it872
    1) (exp it488 3)
    2) (exp it92 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp it488 3)
    2) (exp it872 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it488 2)
    
  Non linear arithmetic between
    0) (exp it488 2)
    1) (exp it872 2)
    
  Non linear arithmetic between
    0) (exp it488 2)
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it488 3)
    
  Non linear arithmetic between
    0) (exp it488 3)
    1) (exp it872 3)
    
  Non linear arithmetic between
    0) (exp it488 3)
    1) (exp it92 3)
    
  Non linear arithmetic between
    0) (exp it868 2)
    
  Non linear arithmetic between
    0) (exp it872 2)
    
  Non linear arithmetic between
    0) (exp it872 3)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  Leftover formula:
  (and
                      (= eee1 (+ (* it488 it872) (* it488 it92)))
                      (= (+ it867 (* (- 2) it13) (* (- 1) i2)) 1)
                      (= (+ it868 (* (- 1) i3) (* 2 it13)) 0)
                      (= (+ it869 (* (- 1) i4 (exp (- 1) it13))) 0)
                      (= (+ it870 (* (- 1) i5 (exp (- 1) it13))) 0)
                      (= (+ it954 (* (- 2) it488 it872) (* (- 2) it488 it92)
                         (* (- 1) it867)) 0)
                      (= (+ it955 (* (- 1) it868) (* 2 it488 it872)
                         (* 2 it488 it92)) 0)
                      (= (+ it956 (* (- 1) it869 (exp (- 1) eee1))) 0)
                      (= (+ it957 (* (- 1) it870 (exp (- 1) eee1))) 0)
                      (= (+ (* (- 24) it872 (exp it488 3) (exp it92 2))
                         (* (- 24) it92 (exp it488 3) (exp it872 2))
                         (* (- 8) (exp it488 3) (exp it872 3))
                         (* (- 8) (exp it488 3) (exp it92 3))
                         (* (- 6) it488 it868 it872) (* (- 6) it488 it868 it92)
                         (* (- 6) it488 it872 (exp it868 2))
                         (* (- 6) it488 it92 (exp it868 2)) (* (- 3) it871)
                         (* (- 1) it488 it872) (* (- 1) it488 it92) (* 3 it958)
                         (* 6 (exp it488 2) (exp it872 2))
                         (* 6 (exp it488 2) (exp it92 2))
                         (* 12 it868 (exp it488 2) (exp it872 2))
                         (* 12 it868 (exp it488 2) (exp it92 2))
                         (* 12 it872 it92 (exp it488 2))
                         (* 24 it868 it872 it92 (exp it488 2))) 0)
                      (= (+ (* (- 8) (exp it13 3)) (* (- 6) i3 it13)
                         (* (- 6) it13 (exp i3 2)) (* (- 3) i6) (* (- 1) it13)
                         (* 3 it871) (* 6 (exp it13 2)) (* 12 i3 (exp it13 2))) 0)
                      (<= 1 it955)
                      (<= (+ (* (- 2) it872) (* (- 1) it868) (* 2 it488 it872)
                          (* 2 it488 it92)) 0)
                      (<= (+ (* (- 2) it872) (* (- 1) it868) (* 2 it488 it872)
                          (* 2 it488 it92)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it868) (* 2 it488 it872)
                          (* 2 it488 it92)) 0)
                      (<= (+ (* (- 1) it868) (* 2 it488 it872)
                          (* 2 it488 it92)) 1)
                      (<= (+ (* (- 1) it868) (* 2 it872) (* 2 it92)) 0)
                      (<= (+ (* (- 1) it868) (* 2 it92)) 1)
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it488) (- 1))
                      (<= (* (- 1) it872) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it13
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it13)
    
  Non linear arithmetic between
    0) it13
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) it488
    1) it868
    2) it872
    
  Non linear arithmetic between
    0) it488
    1) it868
    2) it92
    
  Non linear arithmetic between
    0) it488
    1) it872
    
  Non linear arithmetic between
    0) it488
    1) it872
    2) (exp it868 2)
    
  Non linear arithmetic between
    0) it488
    1) it92
    
  Non linear arithmetic between
    0) it488
    1) it92
    2) (exp it868 2)
    
  Non linear arithmetic between
    0) it868
    1) it872
    2) it92
    3) (exp it488 2)
    
  Non linear arithmetic between
    0) it868
    1) (exp it488 2)
    2) (exp it872 2)
    
  Non linear arithmetic between
    0) it868
    1) (exp it488 2)
    2) (exp it92 2)
    
  Non linear arithmetic between
    0) it869
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it870
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it872
    1) it92
    2) (exp it488 2)
    
  Non linear arithmetic between
    0) it872
    1) (exp it488 3)
    2) (exp it92 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp it488 3)
    2) (exp it872 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it488 2)
    
  Non linear arithmetic between
    0) (exp it488 2)
    1) (exp it872 2)
    
  Non linear arithmetic between
    0) (exp it488 2)
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it488 3)
    
  Non linear arithmetic between
    0) (exp it488 3)
    1) (exp it872 3)
    
  Non linear arithmetic between
    0) (exp it488 3)
    1) (exp it92 3)
    
  Non linear arithmetic between
    0) (exp it868 2)
    
  Non linear arithmetic between
    0) (exp it872 2)
    
  Non linear arithmetic between
    0) (exp it872 3)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
