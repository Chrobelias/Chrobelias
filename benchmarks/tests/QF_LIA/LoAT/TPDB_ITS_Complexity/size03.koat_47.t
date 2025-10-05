size03.koat_47
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_47.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it127 2)
    2) (exp it127 3)
    3) (exp it13 2)
    4) (exp it13 3)
    5) (exp it152 2)
    6) (exp it152 3)
    7) (exp it157 2)
    8) (exp it163 2)
    9) (exp it163 3)
    10) (exp it213 2)
    11) (exp (+ (- 1) it213) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
