a.03.koat_106
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_106.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee3 (+ 1 it176))
                      (= eee2 (+ 1 it134))
                      (= eee1 (+ (- 1) it134))
                      (= (+ it171 (* (- 1) i2) (* (- 1) it134)) 2)
                      (= (+ it174 (* (- 2) i3 (exp 2 eee1))
                         (* (- 1) (exp 2 it134)) (exp 2 it134)) (- 1))
                      (= (+ it175 (* (- 2) i3 (exp 2 it134))
                         (* (- 1) (exp 2 eee2)) (* 2 (exp 2 it134))) (- 2))
                      (= (+ it19 it234 (* (- 1) i4)) 0)
                      (= (+ it198 (* (- 3) i3) (* (- 1) it171)) (- 6))
                      (= (+ it232 (* (- 3) it19) (* (- 1) it198)) 0)
                      (= (+ it250 (* (- 1) it176) (* (- 1) it232)) 0)
                      (= (+ it253 (* (- 2) (exp 2 it176))) (- 1))
                      (= (+ it254 (* (- 2) (exp 2 it176))
                         (* (- 1) (exp 2 eee3))) (- 2))
                      (= (* (- 1) it254) 0)
                      (<= it254 0)
                      (<= (+ it175 (* (- 1) i4)) (- 1))
                      (<= (+ it175 (* (- 1) i4)) 0)
                      (<= (+ it19 (* (- 1) i4)) (- 2))
                      (<= (+ it19 (* (- 1) i4)) (- 1))
                      (<= (+ it254 (* (- 1) it234)) (- 1))
                      (<= (+ it254 (* (- 1) it234)) 0)
                      (<= (+ (* (- 1) i4) (* (- 1) (exp 2 it134))
                          (* 2 i3 (exp 2 eee1)) (exp 2 it134)) 1)
                      (<= (+ (* (- 1) i4) (* (- 1) (exp 2 it134))
                          (* 2 i3 (exp 2 eee1)) (exp 2 it134)) 2)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 1)
                      (<= (+ (* (- 1) i4) (* 2 i3)) 2)
                      (<= (+ (* (- 1) it175) (* 2 i3)) 4)
                      (<= (+ (* (- 1) it234) (exp 2 it176) (exp 2 it176)) 1)
                      (<= (+ (* (- 1) it234) (exp 2 it176) (exp 2 it176)) 2)
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) i4) (- 3))
                      (<= (* (- 1) i4) (- 2))
                      (<= (* (- 1) it134) (- 1))
                      (<= (* (- 1) it176) (- 1))
                      (<= (* (- 1) it19) (- 1))
                      (<= (* (- 1) it234) (- 3))
                      (<= (* (- 1) it234) (- 2))
                      (<= (* (- 1) it254) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) i3
    1) (exp 2 it134)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
