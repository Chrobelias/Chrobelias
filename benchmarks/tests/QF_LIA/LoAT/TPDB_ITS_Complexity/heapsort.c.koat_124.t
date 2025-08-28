heapsort.c.koat_124
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_124.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it147))
                      (= eee1 (+ (- 1) it161))
                      (= (+ it152 (* (- 14) it147) (* (- 1) i2)) 12)
                      (= (+ it154 (* (- 2) (exp 2 it147))) (- 2))
                      (= (+ it155 (* (- 2) (exp 2 it147))) (- 1))
                      (= (+ it157 (* (- 2) (exp 2 it147))) (- 1))
                      (= (+ it158 (* (- 1) (exp 2 it147))) (- 1))
                      (= (+ it159 (* (- 2) (exp 2 it147))) (- 1))
                      (<= 0 (* (- 1) it2))
                      (<= 0 (* (- 1) it237))
                      (<= 0 (* 4 it157))
                      (<= 1 i10)
                      (<= 1 it162)
                      (<= 1 it163)
                      (<= 1 it4)
                      (<= (+ i10 (* (- 2) it157)) 0)
                      (<= (+ it157 (* (- 2) it157)) (- 1))
                      (<= (+ it157 (* (- 1) i10)) 0)
                      (<= (+ (* (- 1) i10) (* 2 it157)) 0)
                      (<= (+ (* (- 1) i10) (* 2 it157 (exp 2 eee1))
                          (exp 2 eee1)) 1)
                      (<= (+ (* (- 1) i10) (* 4 it157)) (- 1))
                      (<= (+ (* (- 1) i10) (* 4 it157)) 0)
                      (<= (+ (* (- 1) i10) (* 4 it157 (exp 2 eee1))
                          (exp 2 it161)) 1)
                      (<= (+ (* (- 1) i10) (* 4 it157 (exp 2 eee1))
                          (exp 2 it161)) 2)
                      (<= (+ (* (- 1) i10) (exp 2 it147) (exp 2 it147)) 1)
                      (<= (+ (* (- 1) i10) (exp 2 it147) (exp 2 it147)) 2)
                      (<= (+ (* (- 1) i10) (exp 2 eee2) (exp 2 eee2)) 1)
                      (<= (* (- 2) it157) 0)
                      (<= (* (- 1) i10) (- 3))
                      (<= (* (- 1) i10) (- 2))
                      (<= (* (- 1) i10) (- 1))
                      (<= (* (- 1) it147) (- 1))
                      (<= (* (- 1) it157) (- 1))
                      (<= (* (- 1) it161) (- 1)))
  Non linear arithmetic between
    0) it157
    1) (exp 2 eee1)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
