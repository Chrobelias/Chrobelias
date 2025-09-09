twn09.koat_2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn09.koat_2.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) it48
    1) (exp 5 eee4)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee3)
    
  Non linear arithmetic between
    0) (exp i4 4)
    
  Non linear arithmetic between
    0) (exp i4 4)
    1) (exp 5 eee4)
    
  Non linear arithmetic between
    0) (exp i4 4)
    1) (exp 16 eee5)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) it48
    1) (exp 5 eee7)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee6)
    
  Non linear arithmetic between
    0) (exp i4 4)
    
  Non linear arithmetic between
    0) (exp i4 4)
    1) (exp 5 eee7)
    
  Non linear arithmetic between
    0) (exp i4 4)
    1) (exp 16 eee8)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Non linear arithmetic between
    0) it48
    1) (exp 5 eee10)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee9)
    
  Non linear arithmetic between
    0) (exp i4 4)
    
  Non linear arithmetic between
    0) (exp i4 4)
    1) (exp 5 eee10)
    
  Non linear arithmetic between
    0) (exp i4 4)
    1) (exp 16 eee11)
    
  Non linear arithmetic between
    0) (exp i5 2)
    
  Leftover formula:
  (and
                      (= eee2 (+ (- 1) it16))
                      (= eee1 (+ (- 2) (* 2 it16)))
                      (= (+ it34 (* (- 1) i2) (* (- 1) i5)) 1)
                      (= (+ it48 (* (- 5) it35) (* (- 1) (exp i4 4))) 0)
                      (= (+ (* (- 2) i3) (* (- 1) i5) (* (- 1) (exp i5 2))
                         (* 2 it35)) 0)
                      (<= 1 i3)
                      (<= (+ it35 (* (- 1) (exp i4 2))) (- 1))
                      (<= (+ (* (- 528) (exp i4 2) (exp 2 eee1))
                          (* (- 192) (exp i4 4) (exp 5 eee2))
                          (* 12 (exp i4 4) (exp 16 it16))
                          (* 132 it48 (exp 5 eee2))) (- 1))
                      (<= (* (- 1) i5) (- 1))
                      (<= (* (- 1) it16) (- 1)))
  Non linear arithmetic between
    0) it48
    1) (exp 5 eee2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    
  Non linear arithmetic between
    0) (exp i4 2)
    1) (exp 2 eee1)
    
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
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
