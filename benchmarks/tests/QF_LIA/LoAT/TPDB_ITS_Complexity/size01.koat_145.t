size01.koat_145
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_145.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it48 2)
    2) (exp it48 3)
    3) (exp it840 2)
    4) (exp (+ (- 1) it840) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
