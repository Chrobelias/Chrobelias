a.03.koat_42
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_42.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee3 (+ (- 1) it57))
                      (= eee2 (+ 1 it134))
                      (= eee1 (+ (- 1) it134))
                      (= (+ it138 (* (- 1) it134) (* (- 1) it60)) 0)
                      (= (+ it141 (* (- 1) it64 (exp 2 eee1))
                         (* (- 1) (exp 2 it134))) (- 1))
                      (= (+ it142 (* (- 1) it64 (exp 2 it134))
                         (* (- 1) (exp 2 eee2))) (- 2))
                      (= (+ it19 it23 (* (- 1) i4)) (- 1))
                      (= (+ it21 (* (- 3) it19) (* (- 1) i2)) 2)
                      (= (+ it60 (* (- 1) it21) (* (- 1) it57)) 0)
                      (= (+ it63 (* (- 2) i3 (exp 2 eee3))) 0)
                      (= (+ it64 (* (- 2) i3 (exp 2 it57))) 0)
                      (= (* (- 1) it142) 2)
                      (<= i3 1)
                      (<= it142 (- 2))
                      (<= (+ it142 (* (- 1) it23)) (- 1))
                      (<= (+ it142 (* (- 1) it23)) 0)
                      (<= (+ it19 (* (- 1) i4)) (- 3))
                      (<= (+ it19 (* (- 1) i4)) (- 2))
                      (<= (+ it19 (* (- 1) i4) (* 2 i3)) (- 1))
                      (<= (+ it19 (* (- 1) i4) (* 2 i3)) 0)
                      (<= (+ it64 (* (- 1) it23)) (- 1))
                      (<= (+ it64 (* (- 1) it23)) 0)
                      (<= (+ (* it64 (exp 2 eee1)) (* (- 1) it23)
                          (exp 2 it134)) 1)
                      (<= (+ (* it64 (exp 2 eee1)) (* (- 1) it23)
                          (exp 2 it134)) 2)
                      (<= (+ (* (- 1) i4) (* 2 i3)) (- 2))
                      (<= (+ (* (- 1) i4) (* 2 i3)) (- 1))
                      (<= (+ (* (- 1) it23) (* 2 i3)) (- 1))
                      (<= (+ (* (- 1) it23) (* 2 i3)) 0)
                      (<= (+ (* (- 1) it23) (* 2 i3 (exp 2 eee3))) (- 1))
                      (<= (+ (* (- 1) it23) (* 2 i3 (exp 2 eee3))) 0)
                      (<= (* (- 1) i3) (- 1))
                      (<= (* (- 1) i4) (- 4))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) it134) (- 1))
                      (<= (* (- 1) it142) (- 1))
                      (<= (* (- 1) it19) (- 1))
                      (<= (* (- 1) it57) (- 1))
                      (<= (* (- 1) it64) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) i3
    1) (exp 2 it57)
    
  Non linear arithmetic between
    0) it64
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) it64
    1) (exp 2 it134)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
