realheapsort_step2.koat_515
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_515.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it87))
                      (= eee1 (+ 1 it273))
                      (= (+ it1219 (* (- 6) it273) (* (- 1) i2)) 5)
                      (= (+ it1222 (* (- 1) (exp 2 eee1))) (- 2))
                      (= (+ it1223 (* (- 2) (exp 2 it273))) (- 2))
                      (= (+ it1229 (* (- 9) i3) (* (- 1) it1219)) (- 36))
                      (<= (+ i3 i3) 1)
                      (<= (+ i3 (* (- 3) i3)) (- 1))
                      (<= (+ i3 (* (- 2) i3 (exp 2 eee2)) (* (- 1) i3)
                          (* (- 1) (exp 2 it87))) (- 3))
                      (<= (+ i3 (* (- 2) it1222)) 2)
                      (<= (+ (* (- 2) i3) (* 2 it1222)) 1)
                      (<= (+ (* (- 1) i3) (* 2 (exp 2 it273))) 0)
                      (<= (+ (* (- 1) i3) (* 2 (exp 2 it273))) 1)
                      (<= (+ (* 2 i3 (exp 2 eee2)) (exp 2 it87)) 3)
                      (<= (* (- 1) i3) (- 5))
                      (<= (* (- 1) i3) (- 4))
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) it273) (- 1))
                      (<= (* (- 1) it87) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 eee2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
