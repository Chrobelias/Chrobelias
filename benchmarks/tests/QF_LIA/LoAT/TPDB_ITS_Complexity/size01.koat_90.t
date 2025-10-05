size01.koat_90
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_90.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it13 2)
    2) (exp it13 3)
    3) (exp it436 2)
    4) (exp it436 3)
    5) (exp it441 2)
    6) (exp it446 2)
    7) (exp it446 3)
    8) (exp it48 2)
    9) (exp it48 3)
    10) (exp it497 2)
    11) (exp (+ (- 1) it497) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
