size04.koat_239
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_239.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it1065 2)
    2) (exp it1069 2)
    3) (exp it1069 3)
    4) (exp it1109 2)
    5) (exp it117 2)
    6) (exp it117 3)
    7) (exp it13 2)
    8) (exp it13 3)
    9) (exp it92 2)
    10) (exp it92 3)
    11) (exp (+ (- 1) it1109) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
