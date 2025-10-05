size02.koat_323
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_323.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it1184 2)
    2) (exp it92 2)
    3) (exp it92 3)
    4) (exp (+ (- 1) it1184) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
