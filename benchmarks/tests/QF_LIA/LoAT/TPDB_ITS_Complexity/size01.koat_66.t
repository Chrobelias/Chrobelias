size01.koat_66
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_66.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it376 2)
    2) (exp it48 2)
    3) (exp it48 3)
    4) (exp (+ (- 1) it376) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
