size02.koat_248
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_248.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it13 2)
    2) (exp it13 3)
    3) (exp it868 2)
    4) (exp (+ (- 1) it868) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
