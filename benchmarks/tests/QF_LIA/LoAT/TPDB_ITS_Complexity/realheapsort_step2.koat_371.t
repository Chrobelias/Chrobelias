realheapsort_step2.koat_371
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_371.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ 1 it273))
                      (= (+ it835 (* (- 6) it273) (* (- 1) i2)) 5)
                      (= (+ it838 (* (- 1) (exp 2 eee1))) (- 2))
                      (= (+ it839 (* (- 2) (exp 2 it273))) (- 2))
                      (= (+ it846 (* (- 9) i3) (* (- 1) it835)) (- 36))
                      (<= (+ i3 i3) 1)
                      (<= (+ i3 (* i3 (exp 2 it87)) (* (- 1) i3) (exp 2 it87)) 3)
                      (<= (+ i3 (* (- 3) i3)) (- 1))
                      (<= (+ i3 (* (- 2) it838)) 2)
                      (<= (+ (* (- 2) i3) (* 2 it838)) 1)
                      (<= (+ (* (- 1) i3) (* 2 (exp 2 it273))) 0)
                      (<= (+ (* (- 1) i3) (* 2 (exp 2 it273))) 1)
                      (<= (+ (* (- 1) i3 (exp 2 it87)) (* (- 1) (exp 2 it87))) (- 3))
                      (<= (* (- 1) i3) (- 5))
                      (<= (* (- 1) i3) (- 4))
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) it273) (- 1))
                      (<= (* (- 1) it87) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 it87)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
