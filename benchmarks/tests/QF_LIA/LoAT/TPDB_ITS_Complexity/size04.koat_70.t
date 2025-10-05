size04.koat_70
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_70.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it117 2)
    2) (exp it117 3)
    3) (exp it122 2)
    4) (exp it128 2)
    5) (exp it128 3)
    6) (exp it13 2)
    7) (exp it13 3)
    8) (exp it255 2)
    9) (exp it92 2)
    10) (exp it92 3)
    11) (exp (+ (- 1) it255) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
