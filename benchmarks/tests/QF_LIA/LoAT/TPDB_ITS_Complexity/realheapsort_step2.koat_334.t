realheapsort_step2.koat_334
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_334.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ 1 it273))
                      (= (+ it645 (* (- 6) it273) (* (- 1) i2)) 5)
                      (= (+ it648 (* (- 1) (exp 2 eee1))) (- 2))
                      (= (+ it649 (* (- 2) (exp 2 it273))) (- 2))
                      (= (+ it730 (* (- 9) i3) (* (- 1) it645)) (- 36))
                      (<= (+ i3 i3) (- 1))
                      (<= (+ i3 i3) 0)
                      (<= (+ i3 (* i3 (exp 2 it650)) (* (- 1) i3)
                          (* 2 (exp 2 it650))) 3)
                      (<= (+ i3 (* i3 (exp 2 it650)) (* (- 1) i3)
                          (* 2 (exp 2 it650))) 4)
                      (<= (+ i3 (* (- 3) i3)) (- 2))
                      (<= (+ i3 (* (- 2) it648)) 2)
                      (<= (+ (* (- 2) i3) (* 2 it648)) 1)
                      (<= (+ (* (- 1) i3) (* 2 (exp 2 it273))) 0)
                      (<= (+ (* (- 1) i3) (* 2 (exp 2 it273))) 1)
                      (<= (* (- 1) i3) (- 5))
                      (<= (* (- 1) i3) (- 4))
                      (<= (* (- 1) i3) (- 3))
                      (<= (* (- 1) i3) (- 2))
                      (<= (* (- 1) it273) (- 1))
                      (<= (* (- 1) it650) (- 1)))
  Non linear arithmetic between
    0) i3
    1) (exp 2 it650)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
