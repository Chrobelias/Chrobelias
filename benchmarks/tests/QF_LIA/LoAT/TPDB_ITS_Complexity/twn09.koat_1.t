twn09.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn09.koat_1.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp (+ i4 (* (- 1) i5)) 4)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp (+ i4 (* (- 1) i5)) 4)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp (+ i4 (* (- 1) i5)) 4)
    
  Non linear arithmetic between
    0) i4
    1) (exp i5 3)
    
  Non linear arithmetic between
    0) i5
    1) (exp i4 3)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i4 3)
    
  Non linear arithmetic between
    0) (exp i4 4)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i5 3)
    
  Non linear arithmetic between
    0) (exp i5 4)
    
  Non linear arithmetic between
    0) (exp (+ i4 (* (- 1) i5)) 4)
    
  Non linear arithmetic between
    0) i4
    1) (exp i5 3)
    
  Non linear arithmetic between
    0) i5
    1) (exp i4 3)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i4 3)
    
  Non linear arithmetic between
    0) (exp i4 4)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i5 3)
    
  Non linear arithmetic between
    0) (exp i5 4)
    
  Non linear arithmetic between
    0) (exp (+ i4 (* (- 1) i5)) 4)
    
  Non linear arithmetic between
    0) i4
    1) (exp i5 3)
    
  Non linear arithmetic between
    0) i5
    1) (exp i4 3)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i4 3)
    
  Non linear arithmetic between
    0) (exp i4 4)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i5 3)
    
  Non linear arithmetic between
    0) (exp i5 4)
    
  Non linear arithmetic between
    0) (exp (+ i4 (* (- 1) i5)) 4)
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it16))
                      (= eee1 (+ (- 2) (* 2 it16)))
                      (= (+ it8 (* (- 5) i3)
                         (* (- 1) (exp (+ i4 (* (- 1) i5)) 4))) 0)
                      (<= i5 0)
                      (<= 1 i3)
                      (<= (+ i3 (* (- 1) (exp i4 2))) (- 1))
                      (<= (+ (* (- 792) (exp i4 2) (exp i5 2) (exp 4 it16))
                          (* (- 528) (exp i4 2) (exp 2 eee1))
                          (* (- 352) i4 (exp i5 3) (exp 5 eee2))
                          (* (- 192) (exp i4 4) (exp 5 eee2))
                          (* (- 176) i5 (exp i4 3) (exp 8 it16))
                          (* (- 33) (exp i5 4)) (* 12 (exp i4 4) (exp 16 it16))
                          (* 33 (exp i5 4) (exp 5 eee2))
                          (* 132 it8 (exp 5 eee2))
                          (* 176 i4 (exp i5 3) (exp 2 it16))
                          (* 1408 i5 (exp i4 3) (exp 5 eee2))
                          (* 3168 (exp i4 2) (exp i5 2) (exp 5 eee2))) (- 1))
                      (<= (* (- 1) it16) (- 1)))
  Non linear arithmetic between
    0) i4
    1) (exp i5 3)
    2) (exp 2 it16)
    
  Non linear arithmetic between
    0) i4
    1) (exp i5 3)
    2) (exp 5 eee2)
    
  Non linear arithmetic between
    0) i5
    1) (exp i4 3)
    2) (exp 5 eee2)
    
  Non linear arithmetic between
    0) i5
    1) (exp i4 3)
    2) (exp 8 it16)
    
  Non linear arithmetic between
    0) it8
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp i5 2)
    2) (exp 4 it16)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp i5 2)
    2) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee1)
    
  Non linear arithmetic between
    0) (exp i4 3)
    
  Non linear arithmetic between
    0) (exp i4 4)
    
  Non linear arithmetic between
    0) (exp i4 4)
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i4 4)
    1) (exp 16 it16)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) (exp i5 3)
    
  Non linear arithmetic between
    0) (exp i5 4)
    
  Non linear arithmetic between
    0) (exp i5 4)
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp (+ i4 (* (- 1) i5)) 4)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
